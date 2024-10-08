vim.loader.enable()

vim.g.mapleader = " " -- Must do this before anything is mapped with leader

vim.opt.backup = false
vim.opt.clipboard = "unnamedplus" -- access system clipboard
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
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
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.guifont = "monospace:h17"
vim.opt.list = true
vim.opt.title = true -- set the title of the window to the file name
vim.opt.listchars = {
  tab = ">-",
  trail = "·",
  extends = "",
  precedes = "",
}
vim.opt.fillchars = {
  eob = " ",
}
vim.opt.spell = true
vim.opt.spelllang = "en_au"
vim.opt.spellcapcheck = ""
vim.opt.spelloptions = "camel"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.g.python3_host_prog = vim.fn.stdpath("cache") .. "/pyvenv/bin/python"

require("user/lazy")
require("user/globals")
require("user/keymaps")

require("user/theme")
require("user/lsp")
require("user/autocommands")
require("user/commands")
require("user/mojo")
