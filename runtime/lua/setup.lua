-- https://neovim.io/doc/user/lua.html
-- https://github.com/nanotee/nvim-lua-guide
--   https://github.com/willelz/nvim-lua-guide-ja/blob/master/README.ja.md
-- https://zenn.dev/slin/articles/2020-11-03-neovim-lua2

if vim.env.USERPROFILE then
	vim.env.PATH = "C:\\Python38;" .. vim.env.PATH
	vim.env.PATH = "C:\\Python38\\Scripts;" .. vim.env.PATH
	vim.env.PATH = vim.env.USERPROFILE .. "\\go\\bin;" .. vim.env.PATH
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
vim.api.nvim_set_keymap("", "<C-n>", ":tabnew<CR>", {})
-- vim.cmd([[nmap <C-n> :lnext<CR>]])
-- vim.cmd([[nmap <C-p> :lprevious<CR>]])

vim.api.nvim_set_keymap("n", "<C-l>", ":nohlsearch<CR><C-l>", { noremap = true })
vim.api.nvim_set_keymap("n", "q", ":close<CR>", { noremap = true })
