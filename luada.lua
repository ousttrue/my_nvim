-- https://gist.github.com/tylerneylon/59f4bcf316be525b30ab
--[[ json.lua

A compact pure-Lua JSON library.
The main functions are: json.stringify, json.parse.

## json.stringify:

This expects the following to be true of any tables being encoded:
 * They only have string or number keys. Number keys must be represented as
   strings in json; this is part of the json spec.
 * They are not recursive. Such a structure cannot be specified in json.

A Lua table is considered to be an array if and only if its set of keys is a
consecutive sequence of positive integers starting at 1. Arrays are encoded like
so: `[2, 3, false, "hi"]`. Any other type of Lua table is encoded as a json
object, encoded like so: `{"key1": 2, "key2": false}`.

Because the Lua nil value cannot be a key, and as a table value is considerd
equivalent to a missing key, there is no way to express the json "null" value in
a Lua table. The only way this will output "null" is if your entire input obj is
nil itself.

An empty Lua table, {}, could be considered either a json object or array -
it's an ambiguous edge case. We choose to treat this as an object as it is the
more general type.

To be clear, none of the above considerations is a limitation of this code.
Rather, it is what we get when we completely observe the json specification for
as arbitrary a Lua object as json is capable of expressing.

## json.parse:

This function parses json, with the exception that it does not pay attention to
\u-escaped unicode code points in strings.

It is difficult for Lua to return null as a value. In order to prevent the loss
of keys with a null value in a json string, this function uses the one-off
table value json.null (which is just an empty table) to indicate null values.
This way you can check if a value is null with the conditional
`val == json.null`.

If you have control over the data and are using Lua, I would recommend just
avoiding null values in your data to begin with.

--]]

local json = {}

-- Internal functions.

local function kind_of(obj)
	if type(obj) ~= "table" then
		return type(obj)
	end
	local i = 1
	for _ in pairs(obj) do
		if obj[i] ~= nil then
			i = i + 1
		else
			return "table"
		end
	end
	if i == 1 then
		return "table"
	else
		return "array"
	end
end

local function escape_str(s)
	local in_char = { "\\", '"', "/", "\b", "\f", "\n", "\r", "\t" }
	local out_char = { "\\", '"', "/", "b", "f", "n", "r", "t" }
	for i, c in ipairs(in_char) do
		s = s:gsub(c, "\\" .. out_char[i])
	end
	return s
end

-- Returns pos, did_find; there are two cases:
-- 1. Delimiter found: pos = pos after leading space + delim; did_find = true.
-- 2. Delimiter not found: pos = pos after leading space;     did_find = false.
-- This throws an error if err_if_missing is true and the delim is not found.
local function skip_delim(str, pos, delim, err_if_missing)
	pos = pos + #str:match("^%s*", pos)
	if str:sub(pos, pos) ~= delim then
		if err_if_missing then
			error("Expected " .. delim .. " near position " .. pos)
		end
		return pos, false
	end
	return pos + 1, true
end

-- Expects the given pos to be the first character after the opening quote.
-- Returns val, pos; the returned pos is after the closing quote character.
local function parse_str_val(str, pos, val)
	val = val or ""
	local early_end_error = "End of input found while parsing string."
	if pos > #str then
		error(early_end_error)
	end
	local c = str:sub(pos, pos)
	if c == '"' then
		return val, pos + 1
	end
	if c ~= "\\" then
		return parse_str_val(str, pos + 1, val .. c)
	end
	-- We must have a \ character.
	local esc_map = { b = "\b", f = "\f", n = "\n", r = "\r", t = "\t" }
	local nextc = str:sub(pos + 1, pos + 1)
	if not nextc then
		error(early_end_error)
	end
	return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

-- Returns val, pos; the returned pos is after the number's final character.
local function parse_num_val(str, pos)
	local num_str = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
	local val = tonumber(num_str)
	if not val then
		error("Error parsing number at position " .. pos .. ".")
	end
	return val, pos + #num_str
end

-- Public values and functions.

function json.stringify(obj, as_key)
	local s = {} -- We'll build the string as an array of strings to be concatenated.
	local kind = kind_of(obj) -- This is 'array' if it's an array or type(obj) otherwise.
	if kind == "array" then
		if as_key then
			error("Can't encode array as key.")
		end
		s[#s + 1] = "["
		for i, val in ipairs(obj) do
			if i > 1 then
				s[#s + 1] = ", "
			end
			s[#s + 1] = json.stringify(val)
		end
		s[#s + 1] = "]"
	elseif kind == "table" then
		if as_key then
			error("Can't encode table as key.")
		end
		s[#s + 1] = "{"
		for k, v in pairs(obj) do
			if #s > 1 then
				s[#s + 1] = ", "
			end
			s[#s + 1] = json.stringify(k, true)
			s[#s + 1] = ":"
			s[#s + 1] = json.stringify(v)
		end
		s[#s + 1] = "}"
	elseif kind == "string" then
		return '"' .. escape_str(obj) .. '"'
	elseif kind == "number" then
		if as_key then
			return '"' .. tostring(obj) .. '"'
		end
		return tostring(obj)
	elseif kind == "boolean" then
		return tostring(obj)
	elseif kind == "nil" then
		return "null"
	else
		error("Unjsonifiable type: " .. kind .. ".")
	end
	return table.concat(s)
end

json.null = {} -- This is a one-off table to represent the null value.

function json.parse(str, pos, end_delim)
	pos = pos or 1
	if pos > #str then
		error("Reached unexpected end of input.")
	end
	local pos = pos + #str:match("^%s*", pos) -- Skip whitespace.
	local first = str:sub(pos, pos)
	if first == "{" then -- Parse an object.
		local obj, key, delim_found = {}, true, true
		pos = pos + 1
		while true do
			key, pos = json.parse(str, pos, "}")
			if key == nil then
				return obj, pos
			end
			if not delim_found then
				error("Comma missing between object items.")
			end
			pos = skip_delim(str, pos, ":", true) -- true -> error if missing.
			obj[key], pos = json.parse(str, pos)
			pos, delim_found = skip_delim(str, pos, ",")
		end
	elseif first == "[" then -- Parse an array.
		local arr, val, delim_found = {}, true, true
		pos = pos + 1
		while true do
			val, pos = json.parse(str, pos, "]")
			if val == nil then
				return arr, pos
			end
			if not delim_found then
				error("Comma missing between array items.")
			end
			arr[#arr + 1] = val
			pos, delim_found = skip_delim(str, pos, ",")
		end
	elseif first == '"' then -- Parse a string.
		return parse_str_val(str, pos + 1)
	elseif first == "-" or first:match("%d") then -- Parse a number.
		return parse_num_val(str, pos)
	elseif first == end_delim then -- End of an object or array.
		return nil, pos + 1
	else -- Parse true, false, or null.
		local literals = { ["true"] = true, ["false"] = false, ["null"] = json.null }
		for lit_str, lit_val in pairs(literals) do
			local lit_end = pos + #lit_str - 1
			if str:sub(pos, lit_end) == lit_str then
				return lit_val, lit_end + 1
			end
		end
		local pos_info_str = "position " .. pos .. ": " .. str:sub(pos, pos + 10)
		error("Invalid json syntax starting at " .. pos_info_str)
	end
end

------------------------------------------------------------------------------
--
-- lua Debug Adapter
--
-- https://microsoft.github.io/debug-adapter-protocol/specification
--
-- # message format(JSON-RPC)
-- Content-Length: length\r\n
-- \r\n
-- byte[length]
------------------------------------------------------------------------------
-- replace global print
print = function(...)
	for _, v in ipairs({ ... }) do
		io.stderr:write(string.format(v))
	end
end

io.stdout:setvbuf("no", 0)
io.stderr:setvbuf("no", 0)
local DA = {
	input = io.stdin,
	output = io.stdout,
	next_seq = 0,
	queue = {},
	running = true,
	breakpoints = {},
	next_breakpoint_id = 1,
}

DA.enqueue = function(da, action)
	table.insert(da.queue, action)
end

DA.add_breakpoint = function(da, source, line)
	local match = da:match_breakpoint(source, line)
	if match then
		return {
			id = match.id,
			source = match.source,
			line = match.line,
			verified = false,
		}
	end

	local bp = {
		id = da.next_breakpoint_id,
		source = source,
		line = line,
		verified = true,
	}
	da.next_breakpoint_id = da.next_breakpoint_id + 1
	table.insert(da.breakpoints, bp)
	return bp
end

DA.match_breakpoint = function(da, source, line, from_hook)
	for i, b in ipairs(da.breakpoints) do
		if from_hook then
			io.stderr:write(string.format("%s:%d <=> %s:%d", b.source, b.line, source, line))
		end
		if b.line == line then
			if b.source == source then
				-- match
				return b
			end
		end
	end
end

DA.new_message = function(da, msg_type)
	local msg = {
		seq = da.next_seq,
		type = msg_type,
	}
	da.next_seq = da.next_seq + 1
	return msg
end

DA.new_response = function(da, seq, command)
	local response = da:new_message("response")
	response["success"] = true
	response["request_seq"] = seq
	response["command"] = command
	return response
end

DA.new_event = function(da, event_name)
	return {
		type = "event",
		event = event_name,
	}
end

DA.launch = function(da)
	local chunk = loadfile(da.debugee.program)

	da.thread = coroutine.create(function()
		-- run
		local rc = chunk(unpack(da.debugee.args)) or 0

		-- exit
		da.running = false
		local event = da:new_event("exited")
		event.body = {
			exitCode = rc,
		}
		da:send_message(event)
	end)

	debug.sethook(da.thread, function(_, line)
		local frame = debug.getinfo(2, "nSluf")

		local debuggerName = "luada.lua"
		if frame.source:sub(-#debuggerName) == debuggerName then
			-- skip debugger code
			return
		end

		local match = da:match_breakpoint(frame.source, line, true)
		if match then
			-- hit breakpoint
			local event = da:new_event("stopped")
			event.body = {
				reason = "breakpoint",
				hitBreakpointIds = { match.id },
			}
			da:send_message(event)

			coroutine.yield()
		end
	end, "l")
end

DA.resume = function(da)
	coroutine.resume(da.thread)
end

------------------------------------------------------------------------------
-- https://microsoft.github.io/debug-adapter-protocol/specification#Requests_Initialize
-- https://microsoft.github.io/debug-adapter-protocol/specification#Requests_Launch
-- https://microsoft.github.io/debug-adapter-protocol/specification#Requests_SetBreakpoints
------------------------------------------------------------------------------
DA.on_request = function(da, parsed)
	if parsed.command == "initialize" then
		da:enqueue(function()
			local event = da:new_event("initialized")
			da:send_message(event)
		end)
		local response = da:new_response(parsed.seq, parsed.command)
		response["body"] = {
			supportsConfigurationDoneRequest = true,
		}
		return response
	elseif parsed.command == "launch" then
		da.debugee = {
			program = parsed.arguments.program,
			args = parsed.arguments.args,
		}
		return da:new_response(parsed.seq, parsed.command)
	elseif parsed.command == "setBreakpoints" then
		local breakpoints = {}
		for i, b in ipairs(parsed.arguments.breakpoints) do
			local created = da:add_breakpoint(parsed.arguments.source.path, b.line)
			if created then
				table.insert(breakpoints, created)
			end
		end
		local response = da:new_response(parsed.seq, parsed.command)
		response.body = {
			breakpoints = breakpoints,
		}
		return response
	elseif parsed.command == "configurationDone" then
		-- enqueue
		da:enqueue(function()
			da:launch()
			da:resume()
		end)
		return da:new_response(parsed.seq, parsed.command)
	else
		error(string.format("unknown command: %q", parsed))
	end
end

DA.on_message = function(da, parsed)
	if parsed.type == "request" then
		return da:on_request(parsed)
	else
		error(string.format("unknown type: %q", parsed))
	end
end

DA.send_message = function(da, message)
	local encoded = json.stringify(message)
	if encoded:find("\n") then
		error("contain LF")
	end
	local encoded_length = string.len(encoded)
	local msg = string.format("Content-Length: %d", encoded_length)
	if package.config:sub(1, 1) == "\\" then
		-- windows
		msg = msg .. "\n\n"
	else
		msg = msg .. "\r\n\r\n"
	end
	msg = msg .. encoded
	da.output:write(msg)
	da.output:flush()
end

DA.process_message = function(da)
	-- dequeue
	while #da.queue > 0 do
		local action = table.remove(da.queue, 1)
		action()
	end

	-- read
	local l = da.input:read("*l")

	local m = string.match(l, "Content%-Length: (%d+)")
	local length = tonumber(m)

	da.input:read("*l")
	local body = da.input:read(length)
	local parsed = json.parse(body)
	local response = DA:on_message(parsed)
	if response then
		da:send_message(response)
	end
end

-- local function format_table(t)
-- 	local tmp = "["
-- 	for k, v in pairs(t) do
-- 		tmp = tmp .. string.format("%q = %q, ", k, v)
-- 	end
-- 	return tmp .. "]"
-- end

DA.loop = function(da)
	while da.running do
		DA:process_message()
	end
end

DA:loop()

io.stderr:write("[luada]exit")
