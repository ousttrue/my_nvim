set mouse=a
set ambiwidth=single
Guifont! Cica:h12
GuiTabline 0
GuiPopupmenu 0
GuiLinespace 5

" Use shift+insert for paste inside neovim-qt,
" see https://github.com/equalsraf/neovim-qt/issues/327#issuecomment-325660764
inoremap <silent>  <S-Insert>  <C-R>+
cnoremap <silent> <S-Insert> <C-R>+

" For Windows, Ctrl-6 does not work. So we use this mapping instead.
nnoremap <silent> <C-6> <C-^>

