-- https://neovim.io/doc/user/lua.html
-- https://github.com/nanotee/nvim-lua-guide
--   https://github.com/willelz/nvim-lua-guide-ja/blob/master/README.ja.md
-- https://zenn.dev/slin/articles/2020-11-03-neovim-lua2

-- @param pos int
-- @param path strring
local function insert_path(pos, path)
	path = path:gsub("/", "\\")

	if vim.env.PATH:find(path) then
		return
	end

	if pos == 0 then
		-- head
		if not path:match(";$") then
			path = path + ";"
		end
		vim.env.PATH = path .. vim.env.PATH
	else
		-- tail
		if not vim.env.PATH:match(";$") then
			path = ";" .. path
		end
		vim.env.PATH = vim.env.PATH .. path
	end
end

if vim.env.USERPROFILE then
	insert_path(-1, "C:\\Python38")
	insert_path(-1, "C:\\Python38\\Scripts")
	insert_path(-1, vim.env.USERPROFILE .. "\\.cargo\\bin")
	insert_path(-1, vim.env.USERPROFILE .. "\\go\\bin")
	insert_path(-1, "C:\\Program Files\\LLVM\\bin")
	insert_path(-1, vim.env.APPDATA .. "\\npm")
end

vim.api.nvim_set_keymap("n", "[prefix]", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Space>", "[prefix]", {})
vim.api.nvim_set_keymap("n", "[bookmark]", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", ",", "[bookmark]", {})
vim.api.nvim_set_keymap("n", "[external]", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "'", "[external]", {})

--
-- colorscheme, text, font
--
vim.o.ambiwidth = "single"
vim.o.termguicolors = true

--
-- settings
--
vim.o.autochdir = true
vim.o.hidden = true
vim.o.ts = 4
vim.o.sw = 4
vim.o.sts = 4
vim.o.expandtab = true
vim.o.inccommand = "split"
vim.o.ic = true
vim.o.clipboard = "unnamed"

--
-- terminal
--
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
-- vim.o.shell = "pwsh.exe"
-- vim.o.shellcmdflag = "-NoProfile -NoLogo -NonInteractive -Command"
vim.cmd([[command! -nargs=* T split | wincmd j | resize 20 | terminal pwsh.exe <args>]])
vim.cmd("autocmd TermOpen * startinsert")

--
-- keymaps
--
-- vim.api.nvim_set_keymap( 'n', 'j', 'gj', {noremap = true} )
vim.api.nvim_set_keymap("n", "<plus>", ":bn<CR>", {})
vim.api.nvim_set_keymap("n", "<minus>", ":bp<CR>", {})
-- paste
vim.cmd("noremap! <S-Insert> <C-R>+")
-- tab
-- vim.api.nvim_set_keymap("", "<C-l>", ":tabn<CR>", {})
-- vim.api.nvim_set_keymap("", "<C-h>", ":tabp<CR>", {})
vim.api.nvim_set_keymap("", "<Space>n", ":tabnew<CR>", {})
vim.cmd([[nmap <C-n> :lnext<CR>]])
vim.cmd([[nmap <C-p> :lprevious<CR>]])

vim.api.nvim_set_keymap("n", "<C-l>", ":nohlsearch<CR><C-l>", { noremap = true })
vim.api.nvim_set_keymap("n", "q", ":close<CR>", { noremap = true })
