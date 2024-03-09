vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = os.getenv("HOME") .. "/.jdtls/" .. project_name
vim.cmd("GuardDisable")
local bundles = {
  vim.fn.glob(
    vim.fn.stdpath("data")
      .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
    1
  ),
}
vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar", 1),
    "\n"
  )
)

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    "/opt/homebrew/Cellar/openjdk/21.0.1/libexec/openjdk.jdk/Contents/Home/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    -- string.format("-javaagent:%s/lombok.jar", dependencies_dir),
    -- string.format("-Xbootclasspath/a:%s/lombok.jar", dependencies_dir),
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    (
      vim.fn.stdpath("data")
      .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar"
    ),
    "-configuration",
    (vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_mac_arm"),
    "-data",
    workspace_dir,
  },
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
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
      format = {
        settings = {
          url = vim.fn.stdpath("config") .. "/java-fmt.xml",
        },
      },
    },
  },
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = bundles,
  },
  on_attach = function(_, _)
    -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
    -- you make during a debug session immediately.
    -- Remove the option if you do not want that.
    -- You can use the `JdtHotcodeReplace` command to trigger it manually
    require("jdtls").setup_dap({ config_overrides = { hotcodereplace = "auto" } })
    require("jdtls.dap").setup_dap_main_class_configs()
  end,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
