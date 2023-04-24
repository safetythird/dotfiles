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
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.o.termguicolors = true
      vim.cmd('colorscheme duskfox')
    end
  },
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
    config = function() require("treesittersetup") end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
      "RRethy/nvim-treesitter-endwise",
    },
  },

  { "windwp/nvim-autopairs",    config = function() require("nvim-autopairs").setup {} end },
  {
    "epwalsh/obsidian.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("obsidiansetup") end
  },
  {
    "neovim/nvim-lspconfig",
    config = function() require("lspsetup") end
  },
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
    config = function() require("cmpsetup") end
  },

  -- "dense-analysis/ale",

  {
    "github/copilot.vim",
    cond = function()
      local copilot_enable = os.getenv("NVIM_COPILOT_ENABLE")
      if (copilot_enable == "" or copilot_enable == nil) then
        return false
      end
      return true
    end,
    config = function()
      vim.g.copilot_node_command = "~/.nvm/versions/node/v16.20.0/bin/node"
      vim.cmd('imap <silent><script><expr> <C-J> copilot#Accept("\\<CR>")')
      vim.g.copilot_no_tab_map = true
    end
  },

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



-- Interface --

vim.o.number = true
vim.o.cursorline = true
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
vim.api.nvim_set_keymap('v', '<Leader>oll', ':ObsidianLink ', { noremap = true })
vim.api.nvim_set_keymap('v', '<Leader>oln', ':ObsidianLinkNew ', { noremap = true })

-- Autocommands --

-- vim.api.nvim_command('autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded {$MYVIMRC}"')
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
  command = 'set ts=2|set sw=2|set linebreak|set breakindent|setl formatoptions+=r|setl comments=b:*,b:-,b:+,b:>'
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
