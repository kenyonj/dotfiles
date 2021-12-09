local cmd = vim.cmd
local exec = vim.api.nvim_exec
local fn = vim.fn
local g = vim.g
local opt = vim.opt

g.mapleader = " "
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.number = true
opt.showmatch = true
opt.foldmethod = "marker"
opt.colorcolumn = { "100", "118" }
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.linebreak = true

-- remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

opt.hidden = true
opt.history = 100
opt.lazyredraw = true
opt.synmaxcol = 240

opt.termguicolors = true
opt.background = "dark"
cmd [[colorscheme gruvbox]]

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]
cmd [[autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2]]

opt.completeopt = "menuone,noselect"

cmd [[command Term :botright vsplit term://$SHELL]]

cmd [[
  autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
  autocmd TermOpen * startinsert
  autocmd BufLeave term://* stopinsert
]]

local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

opt.shortmess:append "sI"
