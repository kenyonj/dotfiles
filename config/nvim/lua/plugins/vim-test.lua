return {
  {
    "vim-test/vim-test",
    config = function()
      vim.g["test#strategy"] = "tslime"
      vim.g["test#ruby#use_binstubs"] = 1
      vim.g["test#enabled_runners"] = { "ruby#rails", "go#gotest" }

      vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { desc = "Run nearest test" })
      vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Run all tests in file" })
      vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>", { desc = "Run full test suite" })
      vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Run last test" })
      vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", { desc = "Visit test file" })
    end,
    dependencies = {
      "jgdavey/tslime.vim",
    },
  },
  {
    "jgdavey/tslime.vim",
    lazy = false, -- Ensure it loads immediately
  },
}
