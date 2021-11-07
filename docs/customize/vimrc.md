# vimrc

## .gvimrc

```vim
set iminsert=0
set imsearch=-1
set lines=40
set columns=80
set guicursor+=a:blinkon0
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guifont=Cica:h14:cANSI:qDRAFT
set renderoptions=type:directx,renmode:5

" メニューの文字化け回避
set encoding=utf-8
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim
```

## .vimrc

```vim
filetype plugin indent on
syntax enable

set belloff=all
set hidden
set noswapfile nobackup noundofile
set laststatus=2
set ts=4 sw=4 sts=4 expandtab
set hlsearch
set clipboard=
set ambiwidth=double
set autochdir
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
if has('win32')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif
if has('nvim')
    set nopaste
    noremap! <S-Insert> <C-R>+
else
    set t_Co=256
endif

au ColorScheme * hi MatchParen cterm=bold ctermfg=214 ctermbg=black

set conceallevel=0
set ts=4 sw=4 sts=4 expandtab
set hidden
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
set foldmethod=marker
set autochdir
set showmatch
set matchtime=3
set noswapfile nobackup noundofile nowritebackup
set noeb vb t_vb=
set belloff=all
set laststatus=2
set hlsearch
set clipboard+=unnamed
set ambiwidth=double
set ignorecase
set iskeyword+=-
"set virtualedit=all
set background=dark
"if 
set termguicolors
"set autoindent
set fileencodings=utf-8,ucs-bom,default,latin1
set fileformats=unix,dos
if (exists('+colorcolumn'))
	set colorcolumn=80
	highlight ColorColumn ctermbg=9
endif
set previewheight=8
" Shift-K
set keywordprg=:help
```

## source init.vim

```vim
set encoding=utf8
let s:nvim_init = expand('~/AppData/Local/nvim/init.vim')
if filereadable(s:nvim_init)
    execute 'source ' . s:nvim_init
endif
```

