local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- " Remap leader to <space>
noremap <space> <Nop>
let mapleader = " "

" FZF Ag to leader a (Ack!)
noremap <leader>a :Ag<CR>

" FZF Files to leader p
noremap <C-p> :Files<cr>

" ALE shortcuts
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" Double <space> to noh
noremap <leader><space> :noh<cr>

" Window resizing
noremap <leader>= <C-w>=

" Easy navigation of tabs
nnoremap <leader>[ :tabp<cr>
nnoremap <leader>] :tabn<cr>

" tmux navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" Split to current file
nnoremap <leader>eh :Vexplore<cr>
nnoremap <leader>ej :Hexplore<cr>
nnoremap <leader>ek :Hexplore!<cr>
nnoremap <leader>el :Vexplore!<cr>

" Git shortcuts
map <leader>gs :Gstatus<cr>
map <leader>gc :Gcommit<cr>
map <leader>gg :Gbrowse<cr>
map <leader>gb :Gblame<cr>
map <leader>gd :Gdiff<cr>

" Tbro mappings
vmap <silent> <Leader>t :call tbro#run_selection()<cr>
nmap <silent> <Leader>t :call tbro#run_line()<cr>

" Fast tbro thanks to @jyurek
nnoremap ! :Tbro
nnoremap !! :TbroRedo<cr>

" RSpec mappings for vim-rspec
nmap <silent> <leader>rn :TestNearest<CR>
nmap <silent> <leader>rc :TestFile<CR>
nmap <silent> <leader>ra :TestSuite<CR>
nmap <silent> <leader>rl :TestLast<CR>
nmap <silent> <leader>rv :TestVisit<CR>

" Make Y act like other capitals
map Y y$

" escape insert mode quickly
imap jj <Esc>

" Unmap useless keys
noremap Q <Nop>
noremap K <Nop>

noremap <2-LeftMouse> *#

nmap <Leader>d :call pry#insert()<cr>

nmap <Leader>b :cal ReverseBackground()<cr>
function! ReverseBackground()
  if &bg=="light"
    set bg=dark
  else
    set bg=light
  endif
endfunction

nmap <leader>p :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! ToggleNumber()
  if &relativenumber
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunction
map <Leader>r :call ToggleNumber()<cr>

" Hide highlighted terms
map <silent> <leader><cr> :noh<cr>

" use jsx file syntax highlighting
map <Leader>jsx :let g:jsx_ext_required=0<CR>

noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
