vim.cmd [[
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
]]
