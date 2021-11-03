# SignColumn

https://wonderwall.hatenablog.com/entry/2016/03/26/211710
左の方

https://vim-jp.org/vimdoc-ja/sign.html

[* colorscheme]
`:highlight SignColumn guibg=darkgrey`

[* define]
code:.vim
	:sign define piet text=>> texthl=Search
	

[* place]
code:.vim
 :exe ":sign place 2 line=23 name=piet file=" . expand("%:p")

[* place]
code:.vim
	:sign unplace 2
