--
-- lsp
--
local lsp_bin = ""
if vim.fn.has("win32") ~= 0 then
	lsp_bin = "C:/Program Files/LLVM/bin/clangd.exe"
else
	lsp_bin = "/usr/bin/clangd"
end
require("lspconfig").clangd.setup({
    autostart = false,
	cmd = { lsp_bin, "--background-index" },
	on_attach = require("lsp_on_attach"),
})

--
-- dap
--
local dap = require("dap")

local dap_bin = ""
if vim.fn.has("win32") ~= 0 then
	dap_bin = vim.env.USERPROFILE .. "/.vscode/extensions/vadimcn.vscode-lldb-1.6.5/adapter/codelldb.exe"
else
	dap_bin = "/usr/bin/codelldb"
end

dap.adapters.codelldb = {
	type = "executable_server",
	command = dap_bin,
}
dap.configurations.cpp = {
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}
