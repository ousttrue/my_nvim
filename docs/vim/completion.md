# completion

## omnifunc

http://vimdoc.sourceforge.net/htmldoc/version7.html#new-omni-completion
https://vim.fandom.com/wiki/Omni_completion
https://vim.fandom.com/wiki/Omni_completion_popup_menu

インテリセンスみたいな文脈を考慮した補完。素の completion とのインターフェース上の違いは？

```vim
filetype plugin on
set omnifunc=syntaxcomplete#Complete

> `<C-X><C-O>` while open in Insert mode
```

[* vim-lsp]
https://qiita.com/yami_beta/items/1bb1341113e12bcfb1b8

[* 補完関数の実装]
[Vim の complete-functions でハマった http://d.hatena.ne.jp/osyo-manga/20140806/1407291600]

[* 補完の呼び出し]
vimに以下の種類の挿入モード補完がある

|                                            |                      |                        |
| ------------------------------------------ | -------------------- | ---------------------- |
| Whole lines                                | `i_CTRL-X_CTRL-L`    |
| keywords in the current file               | `i_CTRL-X_CTRL-N`    |
| keywords in 'dictionary'                   | `i_CTRL-X_CTRL-K`    |
| keywords in 'thesaurus', thesaurus-style   | `i_CTRL-X_CTRL-T`    |
| keywords in the current and included files | `i_CTRL-X_CTRL-I`    |
| tags                                       | `i_CTRL-X_CTRL-]`    |
| file names                                 | `i_CTRL-X_CTRL-F`    |
| definitions or macros                      | `i_CTRL-X_CTRL-D`    |
| Vim command-line                           | `i_CTRL-X_CTRL-V`    |
| User defined completion                    | `i_CTRL-X_CTRL-U`    |
| omni completion                            | `i_CTRL-X_CTRL-O`    |
| Spelling suggestions                       | `i_CTRL-X_s`         |
| keywords in 'complete'                     | `i_CTRL-N, i_CTRL-P` | これしか使ってなかった |

https://www.xmisao.com/2014/05/04/vim-completefunc.html
https://github.com/neoclide/coc.nvim

[* 起動方法で異なる補完が出る]

```
File completion: <C-X><C-F>
Line completion: <C-X><C-L>
Omni completion: <C-X><C-O>
```

どの補完を使うか考えずに使いたい

> deoplete 複数のソースを統合する。強い
> 一方で十分な量のバッファが開かれていればの `C-n` `C-p` で十分強い。むしろこれより弱くしたくない。

# complete
`set complete=.,w,b,u,t`

# completeopt
`set completeopt+=menu,preview`

# pumvisible
`pumvisible()` pop up menu のことらしい

```vim
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
```

# keyword
`C-N`, `C-P`
`help i^n, i^p`

# 対象を自動で振り分ける例
https://vim.fandom.com/wiki/Smart_mapping_for_tab_completion

```vim
function! Smart_TabComplete()
let line = getline('.') " current line

let substr = strpart(line, -1, col('.')+1) " from the start of the current
" line to one character right
" of the cursor
let substr = matchstr(substr, "[^ \t]\*$") " word till cursor
if (strlen(substr)==0) " nothing to match on empty string
return "\<tab>"
endif
let has_period = match(substr, '\.') != -1 " position of period, if any
let has_slash = match(substr, '\/') != -1 " position of slash, if any
if (!has_period && !has_slash)
return "\<C-X>\<C-P>" " existing text matching
elseif ( has_slash )
return "\<C-X>\<C-F>" " file matching
else
return "\<C-X>\<C-O>" " plugin matching
endif
endfunction

inoremap &lt;tab$gt; &lt;c-r$gt;Smart_TabComplete()&lt;CR$gt;
```

