# quickfix

[quickfix を便利に使う設定](https://thinca.hatenablog.com/entry/20130708/1373210009)

[vimでquickfixを自動で開く](http://webtech-walker.com/archive/2009/09/29213156.html)
> autocmd QuickfixCmdPost make,grep,grepadd,vimgrep if len(getqflist()) != 0 | copen | endif

<https://www.soum.co.jp/misc/vim-no-susume/7/>

## locationlistとの違い
[Quickfix utility for Vim](https://www.sopht.jp/blog/index.php?/archives/458-Quickfix-utility-for-Vim.html)
quickfix は Vim プロセスに対してグローバル
location list は 1 つのウィンドウに対してローカル

## errorformat
[errorformatについて(入門編)](https://qiita.com/rbtnn/items/92f80d53803ce756b4b8)

