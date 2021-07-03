require("lspconfig").clangd.setup({
	cmd = { "C:/Program Files/LLVM/bin/clangd.exe", "--background-index" },
	on_attach = require("lsp_on_attach"),
})
