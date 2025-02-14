return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      {
        "nvim-cmp",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
        },
        opts = function(_, opts)
          opts.snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          }
          table.insert(opts.sources, { name = "luasnip" })
        end,
      },
      {
        "kmarius/jsregexp",
        build = "make install_jsregexp",
      }
    },
    config = function()
      require("luasnip").config.set_config({
        enable_autosnippets = true,
        history = true,
        update_events = "TextChanged,TextChangedI",
      })
      vim.g.luasnip_use_jsregexp = true
    end,
    opts = {
      history = false,
      delete_check_events = "TextChanged",
    },
  }
}
