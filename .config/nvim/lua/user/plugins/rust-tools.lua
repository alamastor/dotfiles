return {
  'simrat39/rust-tools.nvim',
  ft = 'rust',
  config = function()
    local mason = require('user.mason')
    local handlers = require('user.lsp.handlers')
    mason.install_package('codelldb')
    local rt = require('rust-tools')

    rt.setup({
      server = {
        on_attach = handlers.on_attach,
      },
      dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
          (vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/adapter/codelldb'),
          (vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/lldb/lib/liblldb.so')
        ),
      },
    })
  end,
}
