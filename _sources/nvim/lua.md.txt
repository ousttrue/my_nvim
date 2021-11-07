# Lua

*   [Getting started using Lua in Neovim](https://github.com/willelz/nvim-lua-guide-ja/blob/master/README.ja.md)

## lua 書き換え対応表

| vim                   | lua                                                                   |
|-----------------------|-----------------------------------------------------------------------|
| let g:hoge = 1        | vim.api.nvim\_set\_var("hoge", 1)                                     |
| nnoremap ,, :Some<CR> | vim.api.nvim\_set\_keymap("n", ",,", ":Some<CR>", { noremap = true }) |

## init.lua

<https://oroques.dev/notes/neovim-init/>

