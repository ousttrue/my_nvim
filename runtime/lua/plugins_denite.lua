local M = {}

M.denite_keymap = function()
	local bufnr = vim.api.nvim_buf_get_number("%")
	local opts = { noremap = true, silent = true, expr = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<CR>", "denite#do_map('do_action')", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "d", "denite#do_map('do_action', 'delete')", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "p", "denite#do_map('do_action', 'preview')", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "denite#do_map('quit')", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "i", "denite#do_map('open_filter_buffer')", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<Space>", "denite#do_map('toggle_select').'j'", opts)

	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-n>", "denite#do_map('move_to_next_line')", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-p>", "denite#do_map('move_to_previous_line')", opts)
end

-- https://secret-garden.hatenablog.com/entry/2021/05/16/152715
M.filter_keymap = function()
	vim.cmd([[
    augroup ftplugin-my-denite
        autocmd! * <buffer>
       " denite-filter 用のキーマッピング
       " NOTE: このタイミングじゃないとキーマッピングが反映されない
       " フィルタリング中に Enter を押すと選択されている候補のデフォルトアクションを実行する
        autocmd InsertEnter <buffer> imap <silent><buffer> <CR> <ESC><CR><CR>
       " インサートを抜けた時に自動的にフィルタウィンドウを閉じる
        autocmd InsertEnter <buffer> inoremap <silent><buffer> <Esc> <Esc><C-w><C-q>:<C-u>call denite#move_to_parent()<CR>
    augroup END
	]])

	-- vim.fn["deoplete#custom#buffer_option"]("auto_complete", false)

	vim.wo.statusline = "%!denite#get_status('sources')"

	local bufnr = vim.api.nvim_buf_get_number("%")
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"i",
		"<C-n>",
		"<Esc>:call denite#move_to_parent()<CR>"
			.. ":call cursor(line('.')+1,0)<CR>"
			.. ":call denite#move_to_filter()<CR>A",
		opts
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"i",
		"<C-p>",
		"<Esc>:call denite#move_to_parent()<CR>"
			.. ":call cursor(line('.')-1,0)<CR>"
			.. ":call denite#move_to_filter()<CR>A",
		opts
	)
end

M.config = function()
	vim.cmd([[autocmd FileType denite lua require("plugins_denite").denite_keymap()]])
	vim.cmd([[autocmd FileType denite-filter lua require("plugins_denite").filter_keymap()]])

	vim.fn["denite#custom#option"]("default", {
		split = "floating",
		start_filter = true,
	})
	vim.fn["denite#custom#var"]("file/rec", "command", { "rg", "--files", "--glob", "!.git" })
	vim.fn["denite#custom#var"]("grep", "command", { "rg", "--threads", "1" })

	vim.api.nvim_set_keymap("n", "<Space><Space>", ":<C-u>DeniteProjectDir file/rec<CR>", {})
	vim.api.nvim_set_keymap("n", "<F3>", ":<C-u>Denite ghq<CR>", {})
end

return M
