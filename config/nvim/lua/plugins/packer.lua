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
  use "jose-elias-alvarez/nvim-lsp-ts-utils"
  use "kyazdani42/nvim-web-devicons"
  use "liuchengxu/vista.vim"
  use "lukas-reineke/indent-blankline.nvim"
  use "mattn/gist-vim"
  use "neovim/nvim-lspconfig"
  use "nvim-treesitter/nvim-treesitter"
  use "ojroques/vim-oscyank"
  use "tpope/vim-commentary"
  use "tpope/vim-obsession"
  use "tpope/vim-rails"
  use "tpope/vim-vinegar"
  use "wbthomason/packer.nvim"
  use "L3MON4D3/LuaSnip"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/nvim-cmp"

  use { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }
  use { "famiu/feline.nvim", requires = { "kyazdani42/nvim-web-devicons" } }
  use { "junegunn/fzf", run = "./install --bin" }
  use { "goolord/alpha-nvim", requires = { "kyazdani42/nvim-web-devicons" } }
  use { "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use { "ibhagwan/fzf-lua", requires = { "kyazdani42/nvim-web-devicons" } }
  use { "github/copilot.vim", run = ":Copilot setup" }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    }
  }
end)
