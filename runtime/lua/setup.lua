-- https://neovim.io/doc/user/lua.html
-- https://github.com/nanotee/nvim-lua-guide
-- https://zenn.dev/slin/articles/2020-11-03-neovim-lua2

--
-- colorscheme
--
vim.cmd([[colorscheme nord]])

--
-- settings
--
vim.cmd([[set termguicolors]])
vim.cmd([[set autochdir]])
vim.cmd([[set hidden]])
vim.cmd([[set ts=4 sw=4 sts=4 expandtab]])

--
-- keymaps
--
-- vim.api.nvim_set_keymap( 'n', 'j', 'gj', {noremap = true} )
vim.cmd([[nnoremap [prefix] <Nop>]])
vim.cmd("nmap <Space> [prefix]")
vim.cmd([[nnoremap [bookmark] <Nop>]])
vim.cmd("nmap , [bookmark]")
vim.cmd([[nnoremap [external] <Nop>]])
vim.cmd("nmap ' [external]")
vim.cmd("nmap <C-Tab> :bn<CR>")
vim.cmd("nmap <C-S-Tab> :bp<CR>")
-- paste
vim.cmd("noremap! <S-Insert> <C-R>+")

vim.cmd([[nmap <C-n> :lnext<CR>]])
vim.cmd([[nmap <C-p> :lprevious<CR>]])
vim.cmd([[nnoremap <C-l> :nohlsearch<CR><C-l>]])
vim.cmd([[nnoremap q :close<CR> ]])

vim.cmd([[nmap <C-_> :Commentary<CR>]])
vim.cmd([[vmap <C-_> :Commentary<CR>]])
vim.cmd([[nmap <C-/> :Commentary<CR>]])
vim.cmd([[vmap <C-/> :Commentary<CR>]])

vim.cmd([[nmap <silent> [prefix]<Space> :<C-u>Telescope<CR>]])
vim.cmd([[nmap <silent> [bookmark], :<C-u>Telescope git_files<CR>]])
vim.cmd([[nmap <silent> [bookmark]g :<C-u>Telescope ghq list<CR>]])

vim.cmd([[let g:netrw_nogx = 1 " disable netrw's gx mapping.]])
vim.cmd([[nmap gx <Plug>(openbrowser-smart-search)]])
vim.cmd([[vmap gx <Plug>(openbrowser-smart-search)]])

vim.cmd("nmap <A-F> :Neoformat<CR>")
