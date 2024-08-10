return {
  "mfussenegger/nvim-jdtls",
  dependencies = {
    "mfussenegger/nvim-dap",
    "williamboman/mason.nvim",
  },
  {
    "JavaHello/spring-boot.nvim",
    lazy = true,
    dependencies = {
      "mfussenegger/nvim-jdtls",
    },
  },
}
