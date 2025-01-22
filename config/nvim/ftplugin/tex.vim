
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

if has('linux')
  let g:vimtex_view_method = "zathura"
elseif has('mac')
  let g:vimtex_view_method = "skim"
  let g:vimtex_view_skim_sync = 1
endif
