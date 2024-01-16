nvim 情報の整理と vitepress による vue の練習？

# TODO

- none-nullls
  - markdown linter
- colorscheme
- search
- grep

# Version

## v0.10.0
## v0.9.2
- @20230907
## v0.9.0
- @2023
## v0.8.0
- [Neovim 40個のおすすめオプション](https://jp.magicode.io/denx/articles/eb5a9c43526e4592937977bf3a959ad3)
- filetype.lua
- @2022 [Neovim 0.8がリリース - filetype.luaのデフォルト有効化など多数の変更 | ソフトアンテナ](https://softantenna.com/blog/neovim-0-8-released/)
### winbar
- [https://twitter.com/neovim/status/1527849682570977282](https://twitter.com/neovim/status/1527849682570977282)

## v0.7.0
- Tree-sitter integration (highlighting, folds)
- Better file-change detection
- TUI as a remote UI ($NVIM, --remote)
- Externalized UI: window layout events, ext_statusline
- Lua remote plugin host
- Embed Neovim everywhere

## v0.6.0
- Unified [[nvim_lsp]] API
- Updated defaults

## v0.5.0 @2021-07-21
- [Neovim News #11 - The Christmas Issue - Neovim](https://neovim.io/news/2021/07)
- Expanded Lua API and user config (init.lua)
- Built-in Language Server Protocol (LSP) support
- Tree-sitter integration (experimental)
- Decorations API improvements: extmarks, virtual text, highlights

## v0.5.1
- Lua API improvements
- LSP support improvements (v3.16 spec coverage, configuration)

# build

```sh
$ cmake -S cmake.deps -B .deps -G Ninja -DCMAKE_BUILD_TYPE=Release
$ cmake --build .deps
$ cmake -S . -B build -G Ninja
$ cmake --build build
$ cmake --install --prefix $HOME/local
```

## msys

`luajit` がビルドできなくて機能が下がる(lazy や telescope が動かない?)

https://zenn.dev/ousttrue/articles/d64d9e31e57913

