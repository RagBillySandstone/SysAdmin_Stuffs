" configure expansion of tabs for .py files
au BufRead,BufNewFile *.py set expandtab

set expandtab		" Use spaces instead of TAB
set tabstop=2		" One TAB equals 2 spaces
set softtabstop=2
set shiftwidth=2	" Spaces to use for autoindent
set autoindent		" Copy indent from current line on new line

set ruler		" show line and column number
syntax on		" syntax highlighting
set smartindent

" keep indentation on comments (#)
" http://vim.wikia.com/wiki/Restoring_indent_after_typing_hash
:inoremap # X<BS>#

