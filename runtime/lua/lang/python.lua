-- require("lspconfig").pylsp.setup({
-- 	on_attach = require("lsp_on_attach"),
-- })
require("lspconfig").pyright.setup({
	on_attach = require("lsp_on_attach"),
})

local dap = require("dap")
dap.adapters.python = {
	type = "executable",
	command = vim.api.nvim_get_var("python3_host_prog"),
	args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
	{
		name = "Launch file",
		type = "python",
		request = "launch",
		program = "${file}",
		pythonPath = function()
			return vim.api.nvim_get_var("python3_host_prog")
		end,
	},
}
