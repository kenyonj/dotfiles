vim.cmd [[packadd packer.nvim]]

local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  use "kyazdani42/nvim-tree.lua"
  use "lukas-reineke/indent-blankline.nvim"

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end
  }

  use "kyazdani42/nvim-web-devicons"
  use "liuchengxu/vista.vim"
  use "nvim-treesitter/nvim-treesitter"
  use { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }
  use "neovim/nvim-lspconfig"

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
    },
  }

  use { "famiu/feline.nvim", requires = { "kyazdani42/nvim-web-devicons" } }

  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup()
    end
  }

  use {
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function ()
        require"alpha".setup(require"alpha.themes.dashboard".opts)
    end
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)
