-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
return function(_, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "<S-Tab>", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "<Tab>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	-- vim.api.nvim_command([[autocmd CursorHold   * lua require'utils'.blameVirtText()]])
	-- vim.api.nvim_command([[autocmd CursorMoved  * lua require'utils'.clearBlameVirtText()]])
	-- vim.api.nvim_command([[autocmd CursorMovedI * lua require'utils'.clearBlameVirtText()]])

	local menu_items = {
		'"K: hover"',
		'"[C-k]: signature"',
		'"gD: goto declaration"',
		'"gd: goto definition"',
		'"gi: goto implementation"',
		'"gr: references"',
		'"[space]D: definition"',
		'"[space]rn: rename"',
		'"[space]ca: codeaction"',
		'"[space]q: diagnostic ilst"',
		'"[space]f: format"',
	}
	local menu = "[" .. table.concat(menu_items, ", ") .. "]"

	buf_set_keymap(
		"n",
		"<f4>",
		":call actionmenu#open(" .. menu .. ", {i, item -> execute('normal '.split(item, ':')[0], '')})<CR>",
		opts
	)

	print("lsp_on_attached !")
end
