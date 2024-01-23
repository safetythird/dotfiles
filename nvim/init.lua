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

vim.diagnostic.config({
	severity_sort = true,
	float = {
		source = "always",
	}
})

-- Basic mappings
vim.g.mapleader = ' '
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<Esc>', '<Esc>:nohlsearch<CR><Esc>', { silent = true })
vim.keymap.set('n', '<Leader>w', ':write<CR>')
vim.keymap.set('n', '<Leader>n', ':source $MYVIMRC<CR>')
vim.keymap.set('n', '<Leader>q', ':q<CR>')

require("lazy").setup("plugins")

-- Plugin mappings
-- fzf
vim.keymap.set('n', '<C-p>', ':Files<CR>')
vim.keymap.set('n', '<C-b>', ':Buffers<CR>')
vim.keymap.set('n', '<Leader>s', ':Ag ')
-- nvim-tree
vim.keymap.set('n', '<Leader>t', ':NvimTreeToggle<CR>')
-- Obsidian
vim.keymap.set('n', '<Leader>on', ':ObsidianNew ')
vim.keymap.set('n', '<Leader>od', ':vsplit<CR>:ObsidianToday<CR>')
vim.keymap.set('v', '<Leader>oll', ':ObsidianLink ')
vim.keymap.set('v', '<Leader>oln', ':ObsidianLinkNew ')
-- lspsaga
vim.keymap.set('n', '<Leader>a', ':Lspsaga code_action<CR>')
vim.keymap.set('n', '<Leader>rf', ':Lspsaga rename<CR>')
vim.keymap.set('n', '<Leader>rp', ':Lspsaga rename ++project<CR>')
vim.keymap.set('n', 'gh', ':Lspsaga hover_doc<CR>')
vim.keymap.set('n', 'gpp', ':Lspsaga peek_definition<CR>')
vim.keymap.set('n', 'gpt', ':Lspsaga peek_type_definition<CR>')
vim.keymap.set('n', 'gd', ':Lspsaga goto_definition<CR>')
vim.keymap.set('n', 'gl', ':Lspsaga finder<CR>')
vim.keymap.set('n', '[e', function()
	require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set('n', ']e', function()
	require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set('n', '<Leader>e', ':Lspsaga show_line_diagnostics<CR>')


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
	pattern = { 'html', 'svelte', 'sql', 'go', 'javascript', 'jinja.html' },
	command = 'set ts=4|set sw=4|set noexpandtab'
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = { '*.njk' },
	command = 'setfiletype jinja.html'
})
