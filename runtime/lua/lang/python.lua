-- require("lspconfig").pylsp.setup({
-- 	on_attach = require("lsp_on_attach"),
-- })
require("lspconfig").pyright.setup({
    autostart = false,
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

vim.cmd [[
augroup ErrorFormat
    autocmd BufNewFile,BufRead *.py
        \ set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
augroup END
augroup vimrc_python
  au!
  au FileType python set makeprg=python3\ %
augroup END
]]

