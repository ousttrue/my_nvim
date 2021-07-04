require("lspconfig").clangd.setup({
	cmd = { "C:/Program Files/LLVM/bin/clangd.exe", "--background-index" },
	on_attach = require("lsp_on_attach"),
})

local dap = require("dap")

local exe = ""
if vim.fn.has("win32") ~= 0 then
	exe = vim.env.USERPROFILE .. "/.vscode/extensions/vadimcn.vscode-lldb-1.6.5/adapter/codelldb.exe"
else
	exe = "/usr/bin/codelldb"
end

dap.adapters.codelldb = {
	type = "executable_server",
	command = exe,
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
