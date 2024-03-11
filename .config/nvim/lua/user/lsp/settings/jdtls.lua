print(vim.fn.stdpath("config") .. "/lua/user/lsp/settings/java-fmt.xml")
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
        runtimes = {
          {
            name = "JavaSE-11",
            path = "/opt/homebrew/Cellar/openjdk@11/11.0.21/libexec/openjdk.jdk/Contents/Home/",
          },
          {
            name = "JavaSE-17",
            path = "/opt/homebrew/Cellar/openjdk@17/17.0.9/libexec/openjdk.jdk/Contents/Home/",
          },
          {
            name = "JavaSE-21",
            path = "/opt/homebrew/Cellar/openjdk/21.0.1/libexec/openjdk.jdk/Contents/Home/",
            default = true,
          },
        },
      },
    },
  },
}
