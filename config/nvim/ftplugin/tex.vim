
set spell spelllang=en

let g:tex_flavor='latex'
let g:vimtex_compiler_method='latexmk'
let g:vimtex_compiler_latexmk = {'out_dir': 'build'}
let g:vimtex_quickfix_open_on_warning=0
let g:vimtex_quickfix_ignore_filters=[
  \ 'overfull',
  \ 'underfull',
  \ 'packages',
  \ ]

let g:vimtex_view_method = "skim"
let g:vimtex_view_skim_sync = 1
