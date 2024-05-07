vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
local sdkman_javas = vim.env.HOME .. "/.sdkman/candidates/java/"
local config = {
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  cmd = {
    "java", -- Use Mason installed Java
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. vim.fn.expand("$MASON/share/lombok-nightly/lombok.jar"),
    "-Xbootclasspath/a:" .. vim.fn.expand("$MASON/share/lombok-nightly"),
    "-jar",
    vim.fn.expand("$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar"),
    "-configuration",
    vim.fn.expand("$MASON/share/jdtls/config"),
    "-data",
    vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
  },
  settings = {
    java = {
      configuration = {
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
  init_options = {
    bundles = vim.list_extend(
      { vim.fn.expand("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar") },
      vim.split(vim.fn.glob("$MASON/share/java-test/*.jar", true), "\n")
    ),
  },
  capabilities = { workspace = { fileOperations = { willRename = true } } },
}
require("jdtls").start_or_attach(config)
