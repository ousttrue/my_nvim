" Enable Mouse
set mouse=a
Guifont! Cica:h13
GuiTabline 0
GuiPopupmenu 0
" GuiLinespace 5
" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif
set ambiwidth=single
echom "nvim-qt"

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv

" Use shift+insert for paste inside neovim-qt,
" see https://github.com/equalsraf/neovim-qt/issues/327#issuecomment-325660764
inoremap <silent>  <S-Insert>  <C-R>+
cnoremap <silent> <S-Insert> <C-R>+

" For Windows, Ctrl-6 does not work. So we use this mapping instead.
nnoremap <silent> <C-6> <C-^>

