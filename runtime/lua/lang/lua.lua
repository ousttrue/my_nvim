--
-- lua
--
-- local custom_lsp_attach = function(client)
-- 	-- See `:help nvim_buf_set_keymap()` for more information
-- 	vim.api.nvim_buf_set_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
-- 	vim.api.nvim_buf_set_keymap(0, "n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
-- 	-- ... and other keymappings for LSP

-- 	-- Use LSP as the handler for omnifunc.
-- 	--    See `:help omnifunc` and `:help ins-completion` for more information.
-- 	vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")

-- 	-- For plugins with an `on_attach` callback, call them here. For example:
-- 	-- require('completion').on_attach()
-- end

local sumneko_root_path = vim.api.nvim_get_var("my_nvim_root"):gsub("\\", "/") .. "/language_server/lua-language-server"
local sumneko_binary = ""
if vim.fn.has("win32") ~= 0 then
	sumneko_binary = sumneko_root_path .. "/bin/Windows/lua-language-server.exe"
else
	sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
end

require("lspconfig").sumneko_lua.setup({

	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "use", "use_rocks" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
	on_attach = require("lsp_on_attach"),
})

--
-- dap
--
local dap = require("dap")
dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Attach to running Neovim instance",
		host = function()
			local value = vim.fn.input("Host [127.0.0.1]: ")
			if value ~= "" then
				return value
			end
			return "127.0.0.1"
		end,
		port = function()
			local val = tonumber(vim.fn.input("Port: "))
			assert(val, "Please provide a port number")
			return val
		end,
	},
}

dap.adapters.nlua = function(callback, config)
	callback({ type = "server", host = config.host, port = config.port })
end

