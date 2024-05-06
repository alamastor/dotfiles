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
    ft("java"):fmt({
      cmd = "palantir-java-format",
      args = { "--palantir", "-" },
      stdin = true,
    })
    -- Make palantir-java-format work
    vim.env.PALANTIR_JAVA_FORMAT_OPTS = (
      "--add-exports jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED "
      .. "--add-exports jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED "
      .. "--add-exports jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED "
      .. "--add-exports jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED "
      .. "--add-exports jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED"
    )

    require("guard").setup({
      fmt_on_save = true,
      lsp_as_default_formatter = true,
    })
  end,
}
