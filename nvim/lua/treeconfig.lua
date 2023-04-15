vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvimtree = require("nvim-tree")

nvimtree.setup({
  update_focused_file = {
    enable = true,
    update_root = false
  }
})

