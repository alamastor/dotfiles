-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  opts = {
    renderer = {
      group_empty = true,
    },
  },
  tag = "nightly", -- optional, updated every week. (see issue #1193)
}
