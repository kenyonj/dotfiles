return {
  "vim-test/vim-test",
  lazy = false,
  config = function()
    vim.g["test#strategy"] = "neovim"
    vim.g["test#ruby#use_binstubs"] = 1
    vim.g["test#enabled_runners"] = { "ruby#rails", "go#gotest" }
    vim.g["test#neovim#start_normal"] = 1
    vim.g["test#strategy"] = "tmux"

    vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { desc = "Run nearest test" })
    vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Run all tests in file" })
    vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>", { desc = "Run full test suite" })
    vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Run last test" })
    vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", { desc = "Visit test file" })
  end,
}
