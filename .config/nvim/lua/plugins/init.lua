return {
  -- LSP config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
  },

  -- Color schemes
  "ellisonleao/gruvbox.nvim",
  "zanglg/nova.nvim",
  { "tjdevries/colorbuddy.nvim", tag = "v1.0.0" },
  "bbenzikry/snazzybuddy.nvim",

  -- Minimap
  {
    "echasnovski/mini.nvim",
    config = function()
      local minimap = require("mini.map")
      minimap.setup()
      minimap.open()
    end,
  },

  -- Diagnostics
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- File renames
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    config = function()
      require("lsp-file-operations").setup({ debug = true })
    end,
  },

  -- Macro recorder
  {
    "chrisgrieser/nvim-recorder",
    dependencies = { "rcarriga/nvim-notify" }, -- optional
    opts = {},
  },

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

  -- Haskell
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- Keybinding remiders
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },

  -- Vim dev help
  { "folke/neodev.nvim", opts = {} },

  -- Make it transparent
  "xiyaowong/transparent.nvim",

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Fugative
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  -- JUSTFILE
  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },

  -- Sonarlint
  {
    url = "https://gitlab.com/schrieveslaach/sonarlint.nvim.git",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "williamboman/mason.nvim",
    },
    config = function()
      require("sonarlint").setup({
        server = {
          cmd = {
            "sonarlint-language-server",
            "-stdio",
            "-analyzers",
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
          },
        },
        filetypes = {
          "java",
        },
      })
    end,
    ft = {
      "java",
    },
  },

  -- YAML / JSON schemas
  -- used for mason-registry
  "b0o/schemastore.nvim",
}
