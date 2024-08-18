-- Update this path
local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local this_os = vim.loop.os_uname().sysname
local liblldb_path = extension_path
  .. "lldb/lib/liblldb"
  .. (this_os == "Linux" and ".so" or ".dylib")
return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false,
  config = function()
    require("user.common").ensure_mason_installed("codelldb")

    vim.g.rustaceanvim = {
      settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
          },
        },
      },
      dap = {
        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    }
  end,
}
