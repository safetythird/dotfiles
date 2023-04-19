require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "markdown",
    "markdown_inline",
    "c",
    "lua",
    "vim",
    -- "help",
    "python",
    "javascript",
    "ruby",
    "comment",
    "svelte",
    "go",
    "html",
    "sql"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown" }
  },
  indent = { enable = true },
  autotag = { enable = true },
  endwise = { enable = true },
}
