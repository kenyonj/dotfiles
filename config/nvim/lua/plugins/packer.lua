local present, packer = pcall(require, "packer")

if not present then
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd "packadd packer.nvim"
  end

  packer = require("packer")
end

return packer.startup(function()
  use "BlakeWilliams/vim-pry"
  use "BlakeWilliams/vim-tbro"
  use "christoomey/vim-tmux-navigator"
  use "janko-m/vim-test"
  use "liuchengxu/vista.vim"
  use "lukas-reineke/indent-blankline.nvim"
  use "mattn/gist-vim"
  use "neovim/nvim-lspconfig"
  use "nvim-treesitter/nvim-treesitter"
  use "ojroques/vim-oscyank"
  use "tpope/vim-obsession"
  use "tpope/vim-vinegar"
  use "tpope/vim-rails"
  use "wbthomason/packer.nvim"
  use "jose-elias-alvarez/nvim-lsp-ts-utils"
    
  use {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").get_icons()
    end
  }

  use { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }
  use { "famiu/feline.nvim", requires = { "kyazdani42/nvim-web-devicons" } }
  use { "junegunn/fzf", run = "./install --bin" }

  use {
    "ibhagwan/fzf-lua",
    requires = {
      "vijaymarupudi/nvim-fzf",
      "kyazdani42/nvim-web-devicons",
    },
  }

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
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup({})
    end,
    requires = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    }
  }
end)
