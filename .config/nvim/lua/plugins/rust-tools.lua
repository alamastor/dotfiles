-- Update this path
local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local this_os = vim.loop.os_uname().sysname
local liblldb_path = extension_path
  .. "lldb/lib/liblldb"
  .. (this_os == "Linux" and ".so" or ".dylib")
return {
  "simrat39/rust-tools.nvim",
  ft = "rust",
  config = function()
    local mason = require("user.mason")
    local handlers = require("user.lsp.handlers")
    mason.install_package("codelldb")
    local rt = require("rust-tools")

    rt.setup({
      server = {
        on_attach = handlers.on_attach,
      },
      dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    })
  end,
}
