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
vim.keymap.set('n', '<Leader>q', ':q<CR>')

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
	pattern = { 'html', 'svelte', 'sql', 'go', 'javascript', 'jinja.html', "c" },
	command = 'set ts=4|set sw=4|set noexpandtab'
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = { 'svelte', 'javascript', 'typescript' },
	command = 'set ts=2|set sw=2|set noexpandtab'
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = { '*.njk' },
	command = 'setfiletype jinja.html'
})


-- User commands --
vim.api.nvim_create_user_command(
	'FixTabs',
	function(opts)
		local config_ts = vim.opt.ts:get()
		local file_ts = opts.fargs[1]
		vim.opt_local.ts = tonumber(file_ts)
		vim.cmd('%retab!')
		vim.opt_local.ts = tonumber(config_ts)
	end,
	{ nargs = 1 }
)

-- Load plugins --
require("lazy").setup("plugins")
