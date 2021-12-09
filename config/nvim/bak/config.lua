local opt = vim.opt

vim.cmd [[syntax on]]

opt.autoindent = true               -- Copy indent from previous line
opt.backupcopy = 'yes'              -- Keeps original creator code
opt.backspace = 'indent,eol,start'  -- Adds intuitive backspacing
opt.colorcolumn = '100,118'         -- Highlight lines 100 & 118 (GitHub PR code view window width limit is 118)
opt.diffopt:append('vertical')      -- Always use vertical diffs
opt.fillchars:append('vert:│')      -- Use tall pipe in split separators
-- set gdefault = true                -- When on a line, replace all matches in line
opt.history = 100                   -- Keep 100 lines of command line history
opt.hlsearch = true                 -- Highlights search
opt.ignorecase = true               -- Ignore case in searches
opt.incsearch = true                -- Searches for text as entered
opt.laststatus = 2                  -- Always show statusline
opt.list = true                     -- Don't show listchars
opt.listchars = 'tab:»·,trail:·'    -- Show trailing spaces as dots
opt.matchtime = 0                   -- Fix neovim match lag
opt.backup = false                  -- No Backup files
opt.errorbells = false              -- Obvious
opt.hidden = false                  -- Don't hide unsaved buffers
opt.number = true                   -- Show regular numbers
opt.showcmd = false                 -- Don't show command in the last line of the screen
opt.swapfile = false                -- No swap
opt.wrap = false                    -- Don't wrap lines
-- set relativenumber = true          -- Show relative line numbers
opt.ruler = true                    -- Show the ruler
opt.scrolloff = 5                   -- Always show 5 lines above/blow cursor
opt.completeopt:append('menuone')   -- Always show menu
-- set completeopt:append('noselect') -- Don't select only option
opt.shortmess = 'fmnrWIcF'          -- Customize what vim yells at you
opt.showmatch = true                -- Highlight matching paren/brace/bracket
opt.smartcase = true                -- Enable case sensetive search only when uppsercase characters present
opt.smartindent = true              -- Auto insert extra indent level in certain cases
opt.smarttab = true                 -- Prevents tab/space issues
opt.synmaxcol = 180                 -- Prevents segfaults and slow rendering
opt.splitbelow = true               -- Open hsplits below rather than above
opt.splitright = true               -- Open vsplits to the right rather than left
opt.tags = '.git/tags'              -- Where to find tags
opt.termguicolors = true            -- 256 colors!
opt.undolevels = 500                -- More undo
opt.wildignorecase = true           -- Case insensitive completions
opt.wildmenu = true
opt.shell = '/bin/zsh'              -- use zsh for the `:terminal` shells

-- Enable italics
-- opt.t_ZH = '[3m'
-- opt.t_ZR = '[23m'

-- Formatting settings
opt.expandtab = true                --  Make spaces not tabs
-- set tabstop = 2                    --  2 space tabs
opt.shiftwidth = 2                  --  2 spaces when indented

-- Vim and OS share clipboard
opt.clipboard = 'unnamed'
vim.cmd [[
  autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif
]]

-- filetype indent on              -- Filetype specific indent
-- filetype plugin on              -- Filetype specific plugins

-- if has('mouse')
--   opt.mouse = a
-- endif

-- -- Use undo file for awesome undo
-- if exists("+undofile")
--   if isdirectory($HOME . '/.vim/undo') == 0
--     :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
--   endif

--   opt.undofile = true
--   opt.undodir= '~/.vim/undo/'
-- endif

-- let test#ruby#rails#executable = 'bin/rails test'

-- let g:coc_global_extensions = ['coc-json', 'coc-prettier']
-- command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
