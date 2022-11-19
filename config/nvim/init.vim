" auto-install vim-plug                                                                                                                
if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall                                                                                                      
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'rhysd/vim-clang-format' 
" PlugInstall for new plugins
call plug#end()

lua require('mhennefarth.settings')
lua require('mhennefarth.plugins')
lua require('mhennefarth.highlights')
lua require('mhennefarth.bootstrap')
