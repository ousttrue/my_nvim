# keymap

* [vimでキーマッピングする際に考えたほうがいいこと](https://deris.hatenablog.jp/entry/2013/05/02/192415)

```vim
" ex mode を無効に
nnoremap Q <Nop>
```

## prefix

```vim
nnoremap [prefix] <Nop>
nmap <Space> [prefix]
nmap <silent> [prefix]n :<C-u>e ~/.config/nvim/init.vim<CR>
```

```vim
imap <Nul> <Nop>
inoremap <C-Space> <c-x><c-o>
imap <C-@> <C-Space>
```

```vim
nmap <C-n> :lnext<CR>
nmap <C-p> :lprevious<CR>
nnoremap <C-l> :nohlsearch<CR><C-l>
nnoremap q :close<CR> 
```

## memo

* [端末上のvimでctrl+space（ついでにプラグインの上書き回避）](https://h-miyako.hatenablog.com/entry/2014/01/20/053327)

`<c-@>` に変換されて insert される？

* https://vim.fandom.com/wiki/Avoid_the_escape_key

[vim のkeymapでCtrl-Spaceが設定できなかったので調べてみた http://d.hatena.ne.jp/dgdg/20080109/1199891258]
> どうやら<C-Space>と指定せずに<Nul>でいけるらしい。

code:.vim
imap <Nul> <Nop>

[端末上のvimでctrl+space（ついでにプラグインの上書き回避） http://h-miyako.hatenablog.com/entry/2014/01/20/053327]


[* Leader]
vim leader
#vim

code:.vim
 " 先に設定する必要あり
 let mapleader = "\<Space>"

code:.vim
	nmap <Leader>f <Plug>(easymotion-overwin-f)

https://postd.cc/how-to-boost-your-vim-productivity/

`<C-r>=XXX()<CR>` => `XXX()の実行結果` に置き換わる

[* 関数呼び出し]
code:.vim
 function! s:some()
     echo "some"
 endfunction
 nnoremap <F5> :call <SID>some()<CR>

