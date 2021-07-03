require("lspconfig").rust_analyzer.setup({
	on_attach = require("lsp_on_attach"),
	settings = {
		["rust-analyzer"] = {
			assist = {
				importGranularity = "module",
				importPrefix = "by_self",
			},
			cargo = {
				loadOutDirsFromCheck = true,
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

local dap = require("dap")
dap.adapters.codelldb = {
	type = "executable_server",
	command = vim.env.USERPROFILE .. "/.vscode/extensions/vadimcn.vscode-lldb-1.6.5/adapter/codelldb.exe",
}
dap.configurations.rust = {
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
