-- vim.fn['plug#begin']()
-- vim.fn['plug#']('tpope/vim-surround')
-- vim.fn['plug#']('numToStr/Comment.nvim')
-- vim.fn['plug#']('junegunn/fzf', { ['do'] = function() vim.fn['fzf#install']() end })
-- vim.fn['plug#']('junegunn/fzf.vim')
-- vim.fn['plug#']('ggandor/leap.nvim')
-- vim.fn['plug#']('EdenEast/nightfox.nvim')
-- vim.fn['plug#']('nvim-tree/nvim-web-devicons') -- nvim-tree optional req, for file icons
-- vim.fn['plug#']('nvim-tree/nvim-tree.lua')
-- vim.fn['plug#']('tpope/vim-fugitive')
-- vim.fn['plug#']('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
-- vim.fn['plug#']('windwp/nvim-autopairs')
-- -- Obsidian
-- vim.fn['plug#']('nvim-lua/plenary.nvim')
-- vim.fn['plug#']('epwalsh/obsidian.nvim')
-- -- LSP
-- vim.fn['plug#']('neovim/nvim-lspconfig')
-- -- Snippets
-- vim.fn['plug#']('dcampos/nvim-snippy')
-- -- Completion
-- vim.fn['plug#']('hrsh7th/cmp-nvim-lsp')
-- vim.fn['plug#']('hrsh7th/cmp-buffer')
-- vim.fn['plug#']('hrsh7th/cmp-path')
-- vim.fn['plug#']('hrsh7th/cmp-cmdline')
-- vim.fn['plug#']('hrsh7th/nvim-cmp')
-- vim.fn['plug#']('dcampos/cmp-snippy')
--
-- vim.fn['plug#']('dense-analysis/ale')
-- vim.fn['plug#']('github/copilot.vim')
--
-- -- Language specific
-- vim.fn['plug#']('Glench/Vim-Jinja2-Syntax')
-- vim.fn['plug#']('ray-x/go.nvim')
-- vim.fn['plug#end']()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "tpope/vim-surround",
  {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end
  },
  {
    "junegunn/fzf",
    dependencies = { "junegunn/fzf.vim" }
  },
  "junegunn/fzf.vim",
  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
      leap.opts.highlight_unlabeled_phase_one_targets = true
    end
  },
  "EdenEast/nightfox.nvim",
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      local nvimtree = require("nvim-tree")

      nvimtree.setup({
        update_focused_file = {
          enable = true,
          update_root = false
        }
      })
    end
  },
  "tpope/vim-fugitive",
  {
    "nvim-treesitter/nvim-treesitter",
    config = "treesittersetup"
  },
  "windwp/nvim-autopairs",
  {
    "epwalsh/obsidian.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = "obsidiansetup"
  },
  "neovim/nvim-lspconfig",
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      -- Snippets
      "dcampos/nvim-snippy",
      "dcampos/cmp-snippy",
    },
    config = "cmpsetup"
  },

  -- "dense-analysis/ale",

  "github/copilot.vim",

  -- Language specific
  { "Glench/Vim-Jinja2-Syntax", ft = "jinja" },
  {
    "ray-x/go.nvim",
    ft = "go",
    config = function()
      require("go").setup()
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require('go.format').goimport()
        end,
        group = format_sync_grp,
      })
    end
  },
})

require("lspsetup")

-- Interface --

vim.o.termguicolors = true
vim.cmd('colorscheme duskfox')
vim.o.number = true
if vim.o.scrolloff == 0 then vim.o.scrolloff = 3 end
if vim.o.sidescrolloff == 0 then vim.o.sidescrolloff = 5 end
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.mouse = ''

-- Mappings --

-- Basic mappings
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })
vim.api.nvim_set_keymap('n', '<Esc><Esc>', '<Esc>:nohlsearch<CR><Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>w', ':write<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>n', ':source $MYVIMRC<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>q', ':q<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>v', ':vnew<CR>', { noremap = true })
-- Native LSP mappings
vim.api.nvim_set_keymap('n', '<Leader>h', ':lua vim.lsp.buf.hover()<CR>', { noremap = true })
-- Plugin mappings
-- fzf
vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-b>', ':Buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>a', ':Ag ', { noremap = true })
-- nvim-tree
vim.api.nvim_set_keymap('n', '<Leader>t', ':NvimTreeToggle<CR>', { noremap = true })
-- Obsidian
vim.api.nvim_set_keymap('n', '<Leader>on', ':ObsidianNew ', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>od', ':vsplit<CR>:ObsidianToday<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>ob', ':ObsidianBacklinks<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>oo', ':ObsidianOpen<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>os', ':ObsidianSearch<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>op', ':ObsidianQuickSwitch<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>oll', ':ObsidianLink ', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>oln', ':ObsidianLinkNew ', { noremap = true })

-- Autocommands --

vim.api.nvim_command('autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded {$MYVIMRC}"')
-- Filetype specific Autocommands
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged', 'FocusLost' }, {
  pattern = { '*.md', '*.txt' },
  command = 'silent! write'
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.lua' },
  callback = function(ev)
    vim.lsp.buf.format()
  end
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'markdown', 'text' },
  command = 'set ts=2|set sw=2|set linebreak|set breakindent'
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'lua' },
  command = 'set ts=2|set sw=2|set expandtab'
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'python' },
  command = 'set ts=4|set sw=4|set expandtab'
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'html', 'svelte', 'sql' },
  command = 'set ts=2|set sw=2|set noexpandtab'
})

-- Plugin settings --

-- Copilot
vim.g.copilot_node_command = "~/.nvm/versions/node/v16.20.0/bin/node"
vim.cmd('imap <silent><script><expr> <C-J> copilot#Accept("\\<CR>")')
vim.g.copilot_no_tab_map = true
