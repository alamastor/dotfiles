-- Allow :wq to close git vim windows
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {"gitcommit", "gitrebase", "gitconfig"},
  callback = function()
    vim.cmd [[
      set bufhidden=delete
    ]]
  end,
})

-- Custom file associations
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

-- Use tabs in makefiles
vim.cmd([[autocmd FileType make set noexpandtab shiftwidth=4 tabstop=4]])
