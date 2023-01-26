call plug#begin()
Plug 'tpope/vim-surround'
" fzf must be installed using homebrew (newer mac only)
Plug '/opt/homebrew/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ggandor/leap.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'nvim-tree/nvim-web-devicons' " nvim-tree optional req, for file icons
Plug 'nvim-tree/nvim-tree.lua'
call plug#end()

:lua require('leapconfig')

let g:termguicolors = 1
colorscheme duskfox

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
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" Auto-write text files
autocmd InsertLeave,TextChanged,FocusLost *.txt silent! write
