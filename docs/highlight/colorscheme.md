# colorscheme

## highlight-group に対して設定する

`:help highlight-groups`

```lua
vim.api.nvim_set_hl
```

```vim
:highlight Normal guibg=Black guifg=White
```

- @2022 [Neovimのカラースキームを編集中のバッファのファイルパスに応じて変える | Atusy's blog](https://blog.atusy.net/2022/04/28/vim-colorscheme-by-buffer/)
- [Trending vim color schemes | vimcolorschemes](https://vimcolorschemes.com/)

## 適用タイミング
- @2017 [.vimrcでのcolorschemeでハマった - 水底](https://amaya382.hatenablog.jp/entry/2017/02/07/194320) 

## カスタマイズ

```vim
colorscheme default
highlight CursorColumn ctermbg=black
set t_Co=256 " reset
```

### autocmd ColorScheme

自動化

```vim
autocmd colorscheme * highlight ErrorMsg ctermfg=213 ctermbg=16
```

