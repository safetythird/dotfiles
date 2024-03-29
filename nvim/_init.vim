call plug#begin()
Plug 'tpope/vim-surround'
Plug 'numToStr/Comment.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ggandor/leap.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'nvim-tree/nvim-web-devicons' " nvim-tree optional req, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'

" Obsidian.nvim
Plug 'nvim-lua/plenary.nvim'
Plug 'epwalsh/obsidian.nvim'

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

Plug 'dense-analysis/ale'

Plug 'github/copilot.vim'

" language-specific
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'ray-x/go.nvim'

call plug#end()

" lua plugin configurations
:lua require('leapconfig')
:lua require('treeconfig')
:lua require('treesitterconfig')
:lua require('cmpconfig')
lua require('obsidianconfig')
lua require('Comment').setup()

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
set mouse=

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>
noremap <Leader>w :write<CR>
noremap <Leader>n :source $MYVIMRC<CR>

function! RemoveTrailingWhitespace()
  %s/\s\+$//g
endfunction

" fzf
noremap <C-p> :Files<CR>
noremap <C-b> :Buffers<CR>
noremap <Leader>a :Ag
" nvim-tree
noremap <Leader>t :NvimTreeToggle<CR>
noremap <Leader>h :lua vim.lsp.buf.hover()<CR>
" Obsidian
noremap <Leader>on :ObsidianNew 
noremap <Leader>od :vsplit <CR> :ObsidianToday<CR>
noremap <Leader>ob :ObsidianBacklinks<CR>
noremap <Leader>oo :ObsidianOpen<CR>
noremap <Leader>os :ObsidianSearch<CR>
noremap <Leader>op :ObsidianQuickSwitch<CR>
noremap <Leader>oll :ObsidianLink 
noremap <Leader>oln :ObsidianLinkNew 

noremap <Leader>v :vnew<CR>

autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded {$MYVIMRC}"
" Auto-write text files
autocmd InsertLeave,TextChanged,FocusLost *.txt,*.md silent! write

autocmd BufWritePre *.lua lua vim.lsp.buf.format()
autocmd FileType markdown,text set ts=2|set sw=2|set linebreak|set breakindent
autocmd FileType lua set ts=2|set sw=2|set expandtab
autocmd FileType python set ts=4|set sw=4|set expandtab
autocmd FileType html,svelte set ts=2|set sw=2|set noexpandtab
autocmd FileType sql set ts=2|set sw=2|set noexpandtab

" copilot
let g:copilot_node_command = "~/.nvm/versions/node/v16.20.0/bin/node"
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
