return {
  "nvimdev/guard.nvim",
  dependencies = {
    "nvimdev/guard-collection",
    -- Mason adds it's bin directory to the PATH, guard will error if one of its
    -- tools are not found when it starts, so need to do this first
    "williamboman/mason.nvim",
  },
  config = function()
    local ft = require("guard.filetype")

    ft("python"):fmt("ruff"):lint("ruff")
    ft("lua"):fmt("stylua")
    ft("sh"):lint("shellcheck")
    ft("typescript"):fmt("prettier")
    ft("java"):fmt({
      cmd = "palantir-java-format",
      args = { "--skip-reflowing-long-strings", "--palantir", "-" },
      stdin = true,
    })
    ft("rust"):fmt("rustfmt")
    -- Make palantir-java-format work
    vim.env.PALANTIR_JAVA_FORMAT_OPTS = (
      "--add-exports jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED "
      .. "--add-exports jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED "
      .. "--add-exports jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED "
      .. "--add-exports jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED "
      .. "--add-exports jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED"
    )

    vim.g.guard_config = {
      fmt_on_save = true,
      lsp_as_default_formatter = true,
    }
  end,
}
