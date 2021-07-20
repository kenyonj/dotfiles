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
