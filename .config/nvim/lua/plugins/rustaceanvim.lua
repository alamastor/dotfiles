-- Update this path
local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local this_os = vim.loop.os_uname().sysname
local liblldb_path = extension_path
  .. "lldb/lib/liblldb"
  .. (this_os == "Linux" and ".so" or ".dylib")
return {
  "mrcjkb/rustaceanvim",
  version = "^3",
  ft = "rust",
  config = function()
    local handlers = require("user.lsp.handlers")
    require("user.common").ensure_mason_installed("codelldb")

    vim.g.rustaceanvim = function()
      local cfg = require("rustaceanvim.config")
      return {
        server = {
          on_attach = handlers.on_attach,
        },
        settings = {
          ["rust-analyzer"] = {
            imports = {
              granularity = {
                group = "module",
              },
              prefix = "self",
            },
            cargo = {
              buildScripts = {
                enable = true,
              },
            },
            procMacro = {
              enable = true,
            },
            check = {
              command = "clippy",
            },
          },
        },
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end
  end,
}
