" nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" control-n opens it up now
map <C-n> :NERDTreeToggle<CR>
