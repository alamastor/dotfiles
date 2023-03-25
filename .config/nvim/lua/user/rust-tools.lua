local mason = require"user.mason"
mason.install_package("codelldb")
local rt = require"rust-tools"

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
  dap = {
    adapter = require"rust-tools.dap".get_codelldb_adapter(
      (vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"),
      (vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.so")
    )
  }
})
