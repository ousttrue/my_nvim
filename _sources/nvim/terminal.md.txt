# terminal

<https://zenn.dev/ryo_kawamata/articles/improve-neovmi-terminal>

init.vim
```vim
" terminal
tnoremap <silent> <ESC> <C-\><C-n>
autocmd TermOpen * startinsert
command! -nargs=* T split | wincmd j | resize 20 | terminal "C:\\Program Files\\PowerShell\\7\\pwsh.exe" <args>
```

## neovim-remote

<https://github.com/mhinz/neovim-remote>

```
$ pip install neovim-remote
```

usage
```
> nvr hoge.txt
> nvr .
```

