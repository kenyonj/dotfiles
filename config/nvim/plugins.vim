" Use deoplete
let g:deoplete#enable_at_startup = 1

" Indent li and p tags properly
let g:html_indent_tags = 'li\|p'

" custom projections
let g:rails_projections = {
\ "test/integration/*_test.rb": {
\   "type": "integration test",
\   "alternate": "app/controllers/{}.rb"
\ },
\ "app/controllers/*_controller.rb": {
\    "affinity": "controller",
\    "template": [
\      "class {camelcase|capitalize|colons}Controller < ApplicationController",
\      "end"
\    ],
\    "type": "controller",
\    "alternate": "test/integration/{}_controller_test.rb"
\ }
\}

" Use ag
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = 'ag --vimgrep'
endif

" Set Gists to secret by default
let g:gist_post_private = 1

" vinegar hide dotfiles
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro nonumber'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_retmap = 1

" disable left click open
let g:netrw_retmap = 1

" disable netrw history
let g:netrw_dirhistmax = 0

" vim-rspec - Use Tbro to run rspec
let g:rspec_command = "Tbro bin/rails test {spec}"

" Set airline theme
" let g:airline_solarized_bg='dark'
" let g:airline_theme="nightfly"
let g:airline_solarized_dark_inactive_border=1
let g:airline_solarized_normal_green=1

" Don't use new symbols symbols
let g:airline_symbols_ascii = 1

" Disable annoying whitespace indicator
let g:airline#extensions#whitespace#enabled=0

" Better tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#ale#enabled = 1

" Better line/column information
let g:airline_section_b = ""
let g:airline_section_z = "%#__accent_bold#%l%#__restore__#:%c"

let g:ale_sign_error="‚ñ≥"
let g:ale_sign_warning="‚úï"

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint', 'tsserver', 'typecheck'],
\}

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'vue': ['prettier'],
\}
let g:ale_fix_on_save=1

let g:ale_ruby_rubocop_executable = 'bin/rubocop'
let g:ale_ruby_ruby_executable = 'bin/safe-ruby'

" Single character modes
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }

let g:test#custom_strategies = {'tbro': function('tbro#send')}
let g:test#strategy = 'tbro'

let g:UltiSnipsSnippetsDir = "~/.config/nvim/snips"
let g:UltiSnipsSnippetDirectories=["snips"]
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:UltiSnipsExpandTrigger="<Nop>"

" Don't hide quotes in json
let g:vim_json_syntax_conceal = 0

let g:indentLine_setColors = 0

" command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
"
" Use tab to trigger CoC
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Allow enter for CoC
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
