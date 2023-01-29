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

" lua plugin configurations
:lua require('leapconfig')
:lua require('treeconfig')

set termguicolors
colorscheme duskfox

set number
if !&scrolloff
  set scrolloff=3
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set ignorecase
set smartcase

let g:mapleader = ' '

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>
noremap <Leader>w :write<CR>
noremap <C-p> :Files<CR>
noremap <Leader>t :NvimTreeToggle<CR>

" autocmd
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded {$MYVIMRC}"
" Auto-write text files
autocmd InsertLeave,TextChanged,FocusLost *.txt silent! write
