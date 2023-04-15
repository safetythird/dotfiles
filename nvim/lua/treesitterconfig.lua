require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "lua", "vim", "help", "python", "javascript", "ruby", "comment", "svelte", "go", "html", "sql" },
	highlight = { enable = true },
	indent = { enable = true},
  autotag = { enable = true },
  endwise = { enable = true },
}
