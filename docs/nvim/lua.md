# Lua

- [Getting started using Lua in Neovim](https://github.com/willelz/nvim-lua-guide-ja/blob/master/README.ja.md)

## lua 書き換え対応表

| vim                     | lua                                                                   |
| ----------------------- | --------------------------------------------------------------------- |
| `let g:hoge = 1`        | `vim.api.nvim_set_var("hoge", 1)`                                     |
| `nnoremap ,, :Some<CR>` | `vim.api.nvim_set_keymap("n", ",,", ":Some<CR>", { noremap = true })` |

## init.lua

https://oroques.dev/notes/neovim-init/
