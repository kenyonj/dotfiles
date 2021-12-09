local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local cmd = vim.cmd

map("n", "<leader>c", ":nohl<CR>", default_opts)
map("i", "jj", "<Esc>", {noremap = true})
map("", "<up>", "<nop>", { noremap = true })
map("", "<down>", "<nop>", { noremap = true })
map("", "<left>", "<nop>", { noremap = true })
map("", "<right>", "<nop>", { noremap = true })
map("n", "<leader>s", ":w<CR>", default_opts)
map("i", "<leader>s", "<C-c>:w<CR>", default_opts)
map("n", "<C-h>", "<C-w>h", default_opts)
map("n", "<C-j>", "<C-w>j", default_opts)
map("n", "<C-k>", "<C-w>k", default_opts)
map("n", "<C-l>", "<C-w>l", default_opts)
map("n", "<leader>q", ":qa!<CR>", default_opts)
map("n", "<C-t>", ":Term<CR>", { noremap = true })

map("n", "<C-n>", ":NvimTreeToggle<CR>", default_opts)
map("n", "<leader>r", ":NvimTreeRefresh<CR>", default_opts)
map("n", "<leader>n", ":NvimTreeFindFile<CR>", default_opts)

map("n", "<C-m>", ":Vista!!<CR>", default_opts)
