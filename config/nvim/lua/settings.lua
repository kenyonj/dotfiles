local cmd = vim.cmd
local exec = vim.api.nvim_exec
local fn = vim.fn
local g = vim.g
local opt = vim.opt

g.mapleader = " "

opt.autoindent = true                         -- Copy indent from previous line
opt.backspace = { "indent", "eol", "start" }  -- Adds intuitive backspacing
opt.backup = false                            -- No Backup files
opt.backupcopy = "yes"                        -- Keeps original creator code
opt.clipboard = "unnamedplus"
opt.colorcolumn = { "100", "118" }
opt.completeopt = { "menuone", "noselect" }
opt.completeopt:append("menuone")             -- Always show menu
opt.diffopt:append("vertical")                -- Always use vertical diffs
opt.errorbells = false                        -- Obvious
opt.expandtab = true
opt.fillchars:append("vert:│")                -- Use tall pipe in split separators
opt.foldmethod = "marker"
opt.hidden = false                            -- Don't hide unsaved buffers
opt.history = 100                             -- Keep 100 lines of command line history
opt.hlsearch = true                           -- Highlights search
opt.ignorecase = true                         -- Ignore case in searches
opt.incsearch = true                          -- Searches for text as entered
opt.laststatus = 2                            -- Always show statusline
opt.lazyredraw = true
opt.linebreak = true
opt.list = true                               -- Don't show listchars
opt.listchars = { tab = "»·", trail = "·" }
opt.matchtime = 0                             -- Fix neovim match lag
opt.mouse = "a"
opt.number = true                             -- Show regular numbers
opt.ruler = true                              -- Show the ruler
opt.scrolloff = 5                             -- Always show 5 lines above/blow cursor
opt.shell = "/bin/zsh"                        -- use zsh for the `:terminal` shells
opt.shiftwidth = 2                            -- 2 spaces when indented
opt.shortmess = "fmnrWIcF"                    -- Customize what vim yells at you
opt.shortmess:append("sI")
opt.showcmd = false                           -- Don"t show command in the last line of the screen
opt.showmatch = true                          -- Highlight matching paren/brace/bracket
opt.smartcase = true                          -- Enable case sensetive search only when uppsercase characters present
opt.smartindent = true                        -- Auto insert extra indent level in certain cases
opt.smarttab = true                           -- Prevents tab/space issues
opt.splitbelow = true                         -- Open hsplits below rather than above
opt.splitright = true                         -- Open vsplits to the right rather than left
opt.swapfile = false                          -- No swap
opt.synmaxcol = 180                           -- Prevents segfaults and slow rendering
opt.tabstop = 4
opt.tags = ".git/tags"                        -- Where to find tags
opt.undolevels = 500                          -- More undo
opt.wildignorecase = true                     -- Case insensitive completions
opt.wildmenu = true
opt.wrap = false                              -- Don"t wrap lines

exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

opt.termguicolors = true
opt.background = "dark"
cmd "colorscheme gruvbox"

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

  if !has("gui_running")
    set timeoutlen=1000
    augroup FastEscape
      autocmd!
      au InsertEnter * set timeoutlen=0
      au InsertLeave * set timeoutlen=1000
    augroup END
  endif

  if has("autocmd")
    autocmd FileType text setlocal textwidth=78
    autocmd FileType gitcommit setlocal spell nonumber norelativenumber
    autocmd FileType netrw setl bufhidden=delete
    autocmd FileType netrw setlocal nonumber relativenumber
    autocmd FileType markdown setlocal spell wrap textwidth=80
    autocmd FileType qf setlocal cc=""
    autocmd FileType rust setlocal cc=90
    autocmd BufNewFile,BufRead *.json.jbuilder set ft=ruby

    autocmd BufRead,BufNewFile *.es6 setfiletype javascript

    autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
  endif

  function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
      let dir=fnamemodify(a:file, ':h')
      if !isdirectory(dir)
        call mkdir(dir, 'p')
      endif
    endif
  endfunction

  augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
  augroup END
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

require("feline").setup()
require("nvim-web-devicons").get_icons()
