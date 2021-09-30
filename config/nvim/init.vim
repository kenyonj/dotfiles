filetype off

" setup Plug
call plug#begin('~/.config/nvim/bundle')

" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" tpope utilities
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-obsession'
" Plug 'tpope/vim-endwise'

" Workflow
Plug 'BlakeWilliams/vim-pry'
Plug 'BlakeWilliams/vim-tbro'
" Plug 'SirVer/ultisnips'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'ervandew/supertab'
Plug 'janko-m/vim-test'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'mileszs/ack.vim'
Plug 'dense-analysis/ale'
Plug 'rhysd/git-messenger.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Languages and markup
Plug 'sheerun/vim-polyglot'

" Colors
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'Yggdroot/indentLine'

" Movement
Plug 'christoomey/vim-tmux-navigator'

Plug 'ojroques/vim-oscyank'

" Deoplete
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

filetype plugin indent on

" Split config up for cleanliness
source $HOME/.config/nvim/config.vim
" source $HOME/.config/nvim/custom_colors/gruvbox.vim
source $HOME/.config/nvim/custom_colors/nightfly.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/shortcuts.vim
source $HOME/.config/nvim/autocommands.vim

" Function to source only if file exists {
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
" }

call SourceIfExists("~/Session.vim")

" Start session tracking in ~/Session.vim
augroup ObsessionGroup
  autocmd!
  " When opening a file, make sure we record the Vim session with its tabs and splits.
  " Checking 'modified' avoids recording a session when reading from stdin.
  " From https://github.com/tpope/vim-obsession/issues/17
  " Calling Obsession when the session is being recorded would pause the recording,
  " that's why we check if v:this_session is empty.
  autocmd VimEnter * nested
      \ if !&modified && empty(v:this_session) |
      \   Obsession ~/|
      \   echo "Recording new session" |
      \ endif
augroup END

