return {
  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      auto_trigger = true,
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
    dependencies = {
      "zbirenbaum/copilot-cmp",
      config = function()
        require("copilot_cmp").setup({})
      end,
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {},
  },
}
