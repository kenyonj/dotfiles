return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {},
    config = function()
      require("refactoring").setup({
        printf_statements = {
          elixir = { "require IEx; IEx.pry" },
          eruby = { '<% require "pry"; binding.pry %>' },
          javascript = { "debugger" },
          ruby = { 'require "pry"; binding.pry' },
          typescript = { "debugger" },
        },
      })
    end,
  },
}
