local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local cmd = vim.cmd

map("n", "<leader><leader>", ":nohl<CR>", default_opts)
map("i", "jj", "<Esc>", {noremap = true})
map("n", "<leader>s", ":w<CR>", default_opts)
map("i", "<leader>s", "<C-c>:w<CR>", default_opts)
map("n", "<C-t>", ":Term<CR>", { noremap = true })

map("n", "<C-n>", ":NvimTreeToggle<CR>", default_opts)
map("n", "<leader>r", ":NvimTreeRefresh<CR>", default_opts)
map("n", "<leader>n", ":NvimTreeFindFile<CR>", default_opts)

map("n", "<C-m>", ":Vista!!<CR>", default_opts)

cmd "let g:tmux_navigator_no_mappings = 1"
map("n", "<C-h>", ":TmuxNavigateLeft<CR>", default_opts)
map("n", "<C-j>", ":TmuxNavigateDown<CR>", default_opts)
map("n", "<C-k>", ":TmuxNavigateUp<CR>", default_opts)
map("n", "<C-l>", ":TmuxNavigateRight<CR>", default_opts)
map("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", default_opts)

map("n", "<c-P>", "<cmd>lua require('fzf-lua').files()<CR>", default_opts)
map("n", "<leader>a", "<cmd>lua require('fzf-lua').grep_project()<CR>", default_opts)

map("n", "<leader>eh", ":Vexplore<CR>", default_opts)
map("n", "<leader>ej", ":Hexplore<CR>", default_opts)
map("n", "<leader>ek", ":Hexplore!<CR>", default_opts)
map("n", "<leader>el", ":Vexplore!<CR>", default_opts)

map("n", "<leader>rn", ":TestNearest<CR>", default_opts)
map("n", "<leader>rc", ":TestFile<CR>", default_opts)
map("n", "<leader>ra", ":TestSuite<CR>", default_opts)
map("n", "<leader>rl", ":TestLast<CR>", default_opts)
map("n", "<leader>rv", ":TestVisit<CR>", default_opts)

map("n", "<leader>d", ":call pry#insert()<cr>", default_opts)

map("n", "<leader>b", ":call ReverseBackground()<cr>", default_opts)
cmd [[
  function! ReverseBackground()
    if &bg=="light"
      set bg=dark
    else
      set bg=light
    endif
  endfunction
]]

map("n", "<leader>r", ":call ToggleNumber()<cr>", default_opts)
cmd [[
  function! ToggleNumber()
    if &relativenumber
      set norelativenumber
      set number
    else
      set relativenumber
    endif
  endfunction
]]
