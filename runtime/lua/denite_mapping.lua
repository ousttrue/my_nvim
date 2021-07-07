return function()
	local bufnr = vim.api.nvim_buf_get_number("%")
	local opts = { noremap = true, silent = true, expr = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<CR>", "denite#do_map('do_action')", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "d", "denite#do_map('do_action', 'delete')", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "p", "denite#do_map('do_action', 'preview')", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "denite#do_map('quit')", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "i", "denite#do_map('open_filter_buffer')", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<Space>", "denite#do_map('toggle_select').'j'", opts)
end
