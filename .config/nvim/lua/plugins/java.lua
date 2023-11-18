return {
  "mfussenegger/nvim-jdtls",
  lazy = true, -- Will load the plugin on an `FT java` event
  config = function()
    local mason = require("user.mason")

    mason.install_package("jdtls")
    mason.install_package("java-debug-adapter")
    mason.install_package("java-test")
  end,
}
