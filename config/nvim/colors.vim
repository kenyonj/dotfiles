" Show currentline as red
hi CursorLineNr ctermfg=1

hi! link CocErrorVirtualText Error
hi! link TSString Yellow
hi! link netrwSymLink Comment

hi! link LspDiagnosticsVirtualTextError Error
hi! link LspDiagnosticsVirtualTextWarning Yellow
hi! link LspDiagnosticsVirtualTextInformation Green
hi! link LspDiagnosticsVirtualTextHint Green

hi! link LspDiagnosticsVirtualTextHint Green

hi! link lualine_b_diagnostics_error_normal Yellow
hi! link lualine_b_diagnostics_error_insert Green

hi! link LspReferenceRead Error
hi! link LspReferenceText Yellow
hi! link LspReferenceWrite Yellow

let g:airline_theme="gruvbox"
