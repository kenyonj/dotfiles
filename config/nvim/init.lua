require("plugins.packer")

if not vim.env.HEADLESS_NEOVIM then
  require("settings")
  require("keymaps")
  require("plugins.indent-blankline")
  require("plugins.vista")
  require("plugins.nvim-cmp")
  require("plugins.nvim-lspconfig")
  require("plugins.nvim-treesitter")
  require("plugins.alpha-nvim")
  require("plugins.obsession")
  require("plugins.rails")
  require("plugins.null-ls")
end
