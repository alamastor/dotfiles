return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Nvim Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Nvim Tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- Gruvbox
  use { "ellisonleao/gruvbox.nvim" }

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim"
    }
  }

  -- Minimap
  use "wfxr/minimap.vim"

  -- Terminal
  use "akinsho/toggleterm.nvim"

  -- Cmp
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
end)
