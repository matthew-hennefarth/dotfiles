" auto-install vim-plug                                                                                                                
if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall                                                                                                      
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'gruvbox-community/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'rhysd/vim-clang-format' 
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'tell-k/vim-autopep8'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'
Plug 'neovim/nvim-lspconfig'
" PlugInstall for new plugins
call plug#end()

lua require('mhennefarth.settings')

" gruvbox Theme
let g:gruvbox_italic = 1
let g:gruvbox_transparent_bg = 1
colorscheme gruvbox

lua require('mhennefarth.plugins.lspconfig')
