return {
  "mfussenegger/nvim-jdtls",
  dependencies = {
    "mfussenegger/nvim-dap",
    {
      "williamboman/mason.nvim",
      opts = {
        registries = {
          "github:alamastor/mason-registry",
          "github:mason-org/mason-registry",
        },
      },
    },
  },
}
