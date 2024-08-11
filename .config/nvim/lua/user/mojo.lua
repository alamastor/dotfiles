vim.api.nvim_create_autocmd("FileType", {
  -- This handler will fire when the buffer's 'filetype' is "python"
  pattern = "mojo",
  callback = function(args)
    vim.lsp.start({
      name = "mojo-lsp",
      cmd = {
        vim.fn.expand("~/.modular/pkg/packages.modular.com_max/bin/mojo-lsp-server"),
        "--log=error",
      },
      root_dir = vim.fs.root(args.buf, { ".git/" }),
    })
  end,
})
