vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
local sdkman_javas = vim.env.HOME .. "/.sdkman/candidates/java/"
local mason_java = mason_dir
  .. (
    vim.fn.has("mac") == 1 and "/packages/openjdk-17/jdk-17.0.2.jdk/Contents/Home/bin/java"
    or "/packages/openjdk-17/jdk-17.0.2/bin/java"
  )
local config = {
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  cmd = {
    mason_java,
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
    "-javaagent:" .. mason_dir .. "/share/lombok-nightly/lombok.jar",
    "-Xbootclasspath/a:" .. mason_dir .. "/share/lombok-nightly",
    "-jar",
    mason_dir .. "/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
    "-configuration",
    mason_dir .. "/share/jdtls/config",
    "-data",
    vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
  },
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
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
    bundles = {},
  },
  capabilities = { workspace = { fileOperations = { willRename = true } } },
}
require("jdtls").start_or_attach(config)
