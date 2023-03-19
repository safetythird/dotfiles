call plug#begin()
Plug 'tpope/vim-surround'
" fzf must be installed using homebrew (newer mac only)
Plug '/opt/homebrew/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ggandor/leap.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'nvim-tree/nvim-web-devicons' " nvim-tree optional req, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'gpanders/editorconfig.nvim'
Plug 'Glench/Vim-Jinja2-Syntax'
" lsp
Plug 'neovim/nvim-lspconfig'
" snippets
Plug 'dcampos/nvim-snippy'
" cmp-nvim
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'dcampos/cmp-snippy'

call plug#end()

" lua plugin configurations
:lua require('leapconfig')
:lua require('treeconfig')
:lua require('treesitterconfig')
:lua require('cmpconfig')

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
noremap <C-b> :Buffers<CR>
noremap <Leader>t :NvimTreeToggle<CR>

autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded {$MYVIMRC}"
" Auto-write text files
autocmd InsertLeave,TextChanged,FocusLost *.txt silent! write

autocmd FileType lua set ts=2|set sw=2|set expandtab
autocmd FileType python set ts=4|set sw=4|set expandtab
