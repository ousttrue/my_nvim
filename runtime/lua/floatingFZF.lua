return function()
	-- vim.env.FZF_DEFAULT_OPTS = " --color=bg:#20242C --border --layout=reverse"
	local width = vim.fn.float2nr(vim.o.columns * 0.9)
	local height = vim.fn.float2nr(vim.o.lines * 0.6)

	local opts = {
		relative = "editor",
		row = (vim.o.lines - height) / 2,
		col = (vim.o.columns - width) / 2,
		width = width,
		height = height,
		style = "minimal",
	}

	local win = vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, opts)
	vim.fn.setwinvar(win, "&winhighlight", "NormalFloat:TabLine")
end
