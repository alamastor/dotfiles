require "packer"
require "treesitter"

-- Nvim Tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
require("nvim-tree").setup()

-- Gruvbox Theme
vim.o.background = "dark"
require("gruvbox").setup({
  contrast = "hard"
})
vim.cmd([[colorscheme gruvbox]])
