# completion

| completion                                   | keymap            |
| -------------------------------------------- | ----------------- |
| 行全体                                       | i_CTRL-X_CTRL-L   |
| 'dictionary' のキーワード                    | i_CTRL-X_CTRL-K   |
| 'thesaurus' のキーワード, thesaurus-style    | i_CTRL-X_CTRL-T   |
| 編集中と外部参照しているファイルのキーワード | i_CTRL-X_CTRL-I   |
| タグ                                         | i_CTRL-X_CTRL-]   |
| ファイル名                                   | i_CTRL-X_CTRL-F   |
| 定義もしくはマクロ                           | i_CTRL-X_CTRL-D   |
| Vimのコマンドライン                          | i_CTRL-X_CTRL-V   |
| ユーザー定義補完                             | i_CTRL-X_CTRL-U   |
| オムニ補完                                   | i_CTRL-X_CTRL-O   |
| スペリング補完                               | i_CTRL-X_s        |
| 'complete' のキーワード                      | i_CTRL-N i_CTRL-P |

- [VimのCTRL-X補完について - daisuzu's notes](https://daisuzu.hatenablog.com/entry/2015/12/05/002129)
- [vim-jp &raquo; Hack #4: Insert mode補完　導入編](https://vim-jp.org/vim-users-jp/2009/05/01/Hack-4.html)

> オムニ補完とユーザー定義補完は機構としては全く同じですが使用目的が異なります。オムニ補完は'filetype'に応じた賢い補完を提供するためにある一方、ユーザー定義補完はユーザーが任意の補完を行うことができるよう提供されています。

- [vim-jp » Hack #9: Insert mode補完　設定編](https://vim-jp.org/vim-users-jp/2009/05/11/Hack-9.html)

## keymap

```vim
set completeopt=menuone,noinsert

" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"
```

## completeopt

- [Vimのビルトイン補完中にfuzzy matchの設定を切り替える](https://zenn.dev/kawarimidoll/articles/262785e8ca05b0)
- [Vimの補完を他エディタやIDEのような挙動にするようにする｜Telin.](https://note.com/telin/n/na87dc604e042)

## 自動トリガー

### InsertCharPre

- [Vimの手動補完を自動でトリガーすれば自動補完になります](https://zenn.dev/kawarimidoll/articles/c14c8bc0d7d73d)
- `InsertCharPre` [LSP 対応の補完プラグインの機能たち](https://zenn.dev/hrsh7th/scraps/565ac089dbaba1)

## completefunc

- @2023 `vim` https://dev.to/cherryramatis/how-to-create-your-own-completion-for-vim-31ip

```vim
function! Complete(findstart, base)
    if a:findstart
        return 補完を開始する列の位置
    endif
    return 補完の候補
endfunction

set completefunc=Complete
```

## completefunc plugins

### sekme.nvim

- https://www.reddit.com/r/neovim/comments/qk5ud2/plugin_sekmenvim_chain_completion_for/

```lua
vim.bo[bufnr].completefunc = "v:lua.trigger_sekme"
```

## complete関数

- [vimで独自の補完を設定する(complete関数の使い方) -- ぺけみさお](https://www.xmisao.com/2014/05/01/vim-complete.html)

## built-in lsp completion

`v0.11.0`

- https://www.reddit.com/r/neovim/comments/1d7j0c1/a_small_gist_to_use_the_new_builtin_completion/
- `lsp.on_attach` [Built-in completion + snippet Neovim setup · GitHub](https://gist.github.com/MariaSolOs/2e44a86f569323c478e5a078d0cf98cc)

```lua
vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
```

https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/completion.lua#L718

https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/completion.lua#L615
