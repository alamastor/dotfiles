return {
  "nvimdev/guard.nvim",
  dependencies = {
    "nvimdev/guard-collection",
  },
  config = function()
    local ft = require("guard.filetype")

    ft("python"):fmt("ruff"):lint("ruff")
    ft("lua"):fmt("stylua")
    ft("sh"):lint("shellcheck")
    ft("java"):fmt({})

    require("guard").setup({
      fmt_on_save = true,
      lsp_as_default_formatter = true,
    })
  end,
}
