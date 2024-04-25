local sdkman_javas = vim.env.HOME .. "/.sdkman/candidates/java/"
return {
  settings = {
    java = {
      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath("config") .. "/lua/user/lsp/settings/java-fmt.xml",
        },
      },
      configuration = {
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        runtimes = {
          {
            name = "JavaSE-17",
            path = sdkman_javas .. "17.0.11-zulu/",
          },
          {
            name = "JavaSE-21",
            path = sdkman_javas .. "21.0.3-zulu/",
            default = true,
          },
        },
      },
    },
  },
}
