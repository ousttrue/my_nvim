# 調べる

`nvim-0.9.0`

- [syntax highlighting - How to get the highlight group of the word under the cursor in Neovim with Treesitter installed? - Vi and Vim Stack Exchange](https://vi.stackexchange.com/questions/39781/how-to-get-the-highlight-group-of-the-word-under-the-cursor-in-neovim-with-trees)
  `Inspect`

- @2013 [Vimでハイライト表示を調べる](https://rcmdnk.com/blog/2013/12/01/computer-vim/)
- [Vim – シンタックスハイライトの設定方法【文字の色の変更も】 | Howpon[ハウポン]](https://howpon.com/21776#i-5)
- @2013 [Vimでカーソル下のハイライト・グループ名を知る](https://hail2u.net/blog/software/vim-show-highlight-group-name-under-cursor.html)

```vim
:echo synIDattr(synID(line("."), col("."), 1), "name")
```

## 一覧

```vim
:highlight
```

現在有効な全てのハイライトグループ

```vim
:source $VIMRUNTIME/syntax/hitest.vim
```

