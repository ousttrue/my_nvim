- [【Neovim】半透明色のウィンドウが開けるようになりました #neovim - Qiita](https://qiita.com/delphinus/items/a202d0724a388f6cdbc3)

# NormalFloat

```vim
" 文字の色を黒、背景色を緑に変更
hi NormalFloat guifg=#2e3440 guibg=#a3be8c
```

# winhighlight

```vim
" 新しい floating window を開いて、そのウィンドウにフォーカスを移す。
" 第２引数が v:true になっているのでフォーカスが移ります。
call nvim_open_win(bufnr(''), v:true, {'relative': 'cursor', 'height': 3, 'width': 10, 'row': 1, 'col': 1})
" Hoge を定義（黄色地に黒文字になります）
hi Hoge guifg=#2e3440 guibg=#ebcb8b
" Hoge をデフォルトのハイライトにする（Normal の代わりに使う）。
set winhighlight=Normal:Hoge
```

- [Neovim example of using winhighlight to dim inactive windows · GitHub](https://gist.github.com/ctaylo21/c3620a945cee6fc3eb3cb0d7f57faf00)

```lua
vim.wo[winid].winhighlight = "FloatBorder:" .. mode.hl_name
```
