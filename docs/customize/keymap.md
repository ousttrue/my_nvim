# keymap
```{index} keymap
```

## 例

```vim
" ex mode を無効に
nnoremap Q <Nop>
" close window, but not delete buffer
nnoremap q :close<CR>
" terminal normal mode by escape
tnoremap <silent> <ESC> <C-\><C-n>
```

関数呼び出し

```vim
function! s:some()
    echo "some"
endfunction
nnoremap <F5> :call <SID>some()<CR>
👇
nnoremap <F5> :echo "some"<CR>
```

## Prefix

```vim
nnoremap [prefix] <Nop>
nmap <Space> [prefix]
nmap <silent> [prefix]n :<C-u>e ~/.config/nvim/init.vim<CR>
```

```vim
nmap <C-n> :lnext<CR>
nmap <C-p> :lprevious<CR>
nnoremap <C-l> :nohlsearch<CR><C-l>
nnoremap q :close<CR> 
```

## Leader
vim leader

```vim
" 先に設定する必要あり
let mapleader = "<Space>"

nmap <Leader>f <Plug>(easymotion-overwin-f)
```

## \<C-Space\>

* [端末上のvimでctrl+space（ついでにプラグインの上書き回避）](https://h-miyako.hatenablog.com/entry/2014/01/20/053327)
* https://vim.fandom.com/wiki/Avoid_the_escape_key
* [vim のkeymapでCtrl-Spaceが設定できなかったので調べてみた](http://d.hatena.ne.jp/dgdg/20080109/1199891258)
* [端末上のvimでctrl+space（ついでにプラグインの上書き回避）](http://h-miyako.hatenablog.com/entry/2014/01/20/053327)


`<c-@>` に変換されて insert される？

```vim
imap <Nul> <Nop>
inoremap <C-Space> <c-x><c-o>
imap <C-@> <C-Space>
```

## Articles

* [vimでキーマッピングする際に考えたほうがいいこと](https://deris.hatenablog.jp/entry/2013/05/02/192415)
* [Vimの生産性を高める12の方法](https://postd.cc/how-to-boost-your-vim-productivity/)

