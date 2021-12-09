local cmd = vim.cmd
local exec = vim.api.nvim_exec
local fn = vim.fn
local g = vim.g
local opt = vim.opt

g.mapleader = " "

opt.clipboard = "unnamedplus"
opt.colorcolumn = { "100", "118" }
opt.completeopt = "menuone,noselect"
opt.expandtab = true
opt.foldmethod = "marker"
opt.hidden = true
opt.history = 100
opt.ignorecase = true
opt.lazyredraw = true
opt.linebreak = true
opt.mouse = "a"
opt.number = true
opt.shiftwidth = 4
opt.shortmess:append "sI"
opt.showmatch = true
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.synmaxcol = 240
opt.tabstop = 4
opt.wrap = false

exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

opt.termguicolors = true
opt.background = "dark"
cmd [[colorscheme gruvbox]]

cmd [[
  au BufWritePre * :%s/\s\+$//e
  autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
  autocmd TermOpen * startinsert
  autocmd BufLeave term://* stopinsert
  autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif
  au BufEnter * set fo-=c fo-=r fo-=o
  autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
  command Term :botright vsplit term://$SHELL
]]

local disabled_built_ins = {
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
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
