require "user/packer"
require "user/treesitter"
require "user/nvim-tree"
require "user/theme"
require "user/lsp"

vim.opt.backup = false
vim.opt.clipboard = "unnamedplus" -- access sytem clipboard
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.mouse = "a" -- enable mouse
vim.opt.showtabline = 0 -- always show tabs
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.writebackup = false -- lock in use files
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.guifont = "monospace:h17"
