return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional for icons
  config = function()
    require("fzf-lua").setup({})
  end,
  keys = {
    {
      "<C-p>",
      function()
        require("fzf-lua").files()
      end,
      desc = "Find Files (FZF-Lua)",
    },
  },
}
