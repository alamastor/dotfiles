-- Allow :wq to close git vim windows
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {"gitcommit", "gitrebase", "gitconfig"},
  callback = function()
    vim.cmd [[
      set bufhidden=delete
    ]]
  end,
})
