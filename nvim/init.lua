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

-- Interface --
vim.o.number = true
vim.o.cursorline = true
if vim.o.scrolloff == 0 then vim.o.scrolloff = 3 end
if vim.o.sidescrolloff == 0 then vim.o.sidescrolloff = 5 end
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.mouse = ''

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
vim.api.nvim_set_keymap('n', ']e', ':lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[e', ':lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })

require("lazy").setup("plugins")

-- Plugin mappings
-- fzf
vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-b>', ':Buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>s', ':Ag ', { noremap = true })
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

vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged', 'FocusLost' }, {
	pattern = { '*.md', '*.txt' },
	command = 'silent! write'
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = { 'markdown', 'text' },
	command = 'set ts=2|set sw=2|set linebreak|set breakindent|setl formatoptions+=r|setl comments=b:*,b:-,b:+,b:>'
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = { 'html', 'svelte', 'sql', 'go' },
	command = 'set ts=2|set sw=2|set noexpandtab'
})
