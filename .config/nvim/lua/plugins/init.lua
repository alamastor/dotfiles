return {
  -- LSP config
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = {
          ui = {
            border = 'none',
            icons = {
              package_installed = '◍',
              package_pending = '◍',
              package_uninstalled = '◍',
            },
          },
          log_level = vim.log.levels.INFO,
          max_concurrent_installers = 4,
        },
      },
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
  },

  -- Color schemes
  'ellisonleao/gruvbox.nvim',
  'zanglg/nova.nvim',
  'tjdevries/colorbuddy.nvim',
  'bbenzikry/snazzybuddy.nvim',

  -- Minimap
  {
    'echasnovski/mini.nvim',
    config = function()
      local minimap = require('mini.map')
      minimap.setup()
      minimap.open()
    end,
  },

  -- Diagnostics
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  -- File renames
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-tree.lua',
    },
  },

  -- Macro recorder
  {
    'chrisgrieser/nvim-recorder',
    dependencies = { 'rcarriga/nvim-notify' }, -- optional
  },

  -- Copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      auto_trigger = true,
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
    dependencies = {
      'zbirenbaum/copilot-cmp',
      config = function()
        require('copilot_cmp').setup({})
      end,
    },
  },

  -- Haskell
  {
    'mrcjkb/haskell-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  -- Keybinding remiders
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },

  -- Vim dev help
  { 'folke/neodev.nvim', opts = {} },

  -- Make it transparent
  'xiyaowong/transparent.nvim',
}
