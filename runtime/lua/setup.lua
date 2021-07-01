-- https://neovim.io/doc/user/lua.html
-- https://github.com/nanotee/nvim-lua-guide
-- https://zenn.dev/slin/articles/2020-11-03-neovim-lua2

vim.cmd([[nnoremap [prefix] <Nop>]])
vim.cmd("nmap <Space> [prefix]")
vim.cmd([[nnoremap [bookmark] <Nop>]])
vim.cmd("nmap , [bookmark]")
vim.cmd([[nnoremap [external] <Nop>]])
vim.cmd("nmap ' [external]")

--
-- colorscheme, text, font
--
vim.cmd([[colorscheme nord]])
vim.cmd("set ambiwidth=single")
vim.cmd([[set termguicolors]])

--
-- terminal
--
vim.cmd("tnoremap <Esc> <C-\\><C-n>")
vim.cmd("command! -nargs=* T split | wincmd j | resize 20 | terminal <args>")
vim.cmd("autocmd TermOpen * startinsert")

--
-- settings
--
vim.cmd([[set autochdir]])
vim.cmd([[set hidden]])
vim.cmd([[set ts=4 sw=4 sts=4 expandtab]])

--
-- keymaps
--
-- vim.api.nvim_set_keymap( 'n', 'j', 'gj', {noremap = true} )
vim.cmd("nmap <plus> :bn<CR>")
vim.cmd("nmap <minus> :bp<CR>")
-- paste
vim.cmd("noremap! <S-Insert> <C-R>+")

vim.cmd([[nmap <C-n> :lnext<CR>]])
vim.cmd([[nmap <C-p> :lprevious<CR>]])
vim.cmd([[nnoremap <C-l> :nohlsearch<CR><C-l>]])
vim.cmd([[nnoremap q :close<CR> ]])
