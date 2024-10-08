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
  { "rose-pine/neovim", name = "rose-pine" },
  { "tjdevries/colorbuddy.nvim", tag = "v1.0.0" },
  "bbenzikry/snazzybuddy.nvim",

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
      require("lsp-file-operations").setup()
    end,
  },

  -- Macro recorder
  {
    "chrisgrieser/nvim-recorder",
    dependencies = { "rcarriga/nvim-notify" }, -- optional
    opts = {},
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

  -- Highlight words
  "RRethy/vim-illuminate",

  -- Quick comment
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },

  -- Undo tree
  "mbbill/undotree",

  -- Gimme a hard time
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Oil file tree
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
