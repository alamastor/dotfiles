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
    local lint = require("guard.lint")

    ft("python"):fmt("ruff"):lint({
      -- Custom ruff config, builtin doesn't include `check` arg, which is now required
      cmd = "ruff",
      args = {
        "check",
        "-n",
        "-e",
        "--output-format",
        "json",
        "-",
        "--stdin-filename",
      },
      stdin = true,
      fname = true,
      parse = lint.from_json({
        attributes = {
          severity = "type",
          lnum = function(js)
            return js["location"]["row"]
          end,
          col = function(js)
            return js["location"]["column"]
          end,
        },
        severities = {
          E = lint.severities.error, -- pycodestyle errors
          W = lint.severities.warning, -- pycodestyle warnings
          F = lint.severities.info, -- pyflakes
          A = lint.severities.info, -- flake8-builtins
          B = lint.severities.warning, -- flake8-bugbear
          C = lint.severities.warning, -- flake8-comprehensions
          T = lint.severities.info, -- flake8-print
          U = lint.severities.info, -- pyupgrade
          D = lint.severities.info, -- pydocstyle
          M = lint.severities.into, -- Meta
        },
        source = "ruff",
      }),
    })
    ft("lua"):fmt("stylua")
    ft("sh"):lint({
      cmd = "shellcheck",
      args = { "--format", "json1", "--external-sources", "-" },
      stdin = true,
      parse = require("guard.lint").from_json({
        get_diagnostics = function(...)
          return vim.json.decode(...).comments
        end,
        -- https://github.com/koalaman/shellcheck/blob/master/shellcheck.1.md
        attributes = {
          severity = "level",
        },
        source = "shellcheck",
      }),
    })
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
