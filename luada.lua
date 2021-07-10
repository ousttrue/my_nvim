--
-- lua Debug Adapter
--

-- spwan
-- lua exe

-- stdin & stdout use DAP transport
while true do
	local l = io.stdin:read("*l")
	io.stderr:write("[luada]")
	io.stderr:write(l)
end
