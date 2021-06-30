-- settings
vim.cmd[[set termguicolors]]

-- keymaps
vim.cmd[[nmap <C-n> :lnext<CR>]]
vim.cmd[[nmap <C-p> :lprevious<CR>]]
vim.cmd[[nnoremap <C-l> :nohlsearch<CR><C-l>]]
vim.cmd[[nnoremap q :close<CR> ]]

vim.cmd[[nmap <C-_> :Commentary<CR>]]
vim.cmd[[vmap <C-_> :Commentary<CR>]]
vim.cmd[[nmap <C-/> :Commentary<CR>]]
vim.cmd[[vmap <C-/> :Commentary<CR>]]

vim.cmd[[nmap <silent> <Space><Space> :<C-u>Telescope<CR>]]
vim.cmd[[nmap <silent> ,, :<C-u>NvimTreeToggle<CR>]]

vim.cmd[[let g:netrw_nogx = 1 " disable netrw's gx mapping.]]
vim.cmd[[nmap gx <Plug>(openbrowser-smart-search)]]
vim.cmd[[vmap gx <Plug>(openbrowser-smart-search)]]

-- colorscheme
vim.cmd[[colorscheme nord]]

