call plug#begin()
Plug 'tpope/vim-surround'
" fzf must be installed using homebrew (newer mac only)
Plug '/opt/homebrew/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded {$MYVIMRC}"

set number
if !&scrolloff
  set scrolloff=3
endif
if !&sidescrolloff
  set sidescrolloff=5
endif

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <C-p> :Files<CR>

" Auto-write text files
autocmd InsertLeave,TextChanged,FocusLost *.txt silent! write
