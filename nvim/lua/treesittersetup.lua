require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "markdown",
    "markdown_inline",
    "c",
    "lua",
    "vim",
    "python",
    "javascript",
    "ruby",
    "comment",
    "svelte",
    "go",
    "html",
    "sql"
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown" }
  },
  indent = { enable = true },
  autotag = { enable = true },
  endwise = { enable = true },
}
