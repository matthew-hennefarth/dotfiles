" autd-install vim-plug                                                                                                                
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
" PlugInstall for new plugins
call plug#end()

" normal vim stuff 
set tabstop=2
set expandtab
syntax on set number
set number
set showmatch
set t_Co=256
set smarttab
set smartindent
set shiftwidth=2
set background=dark
set laststatus=2

"cleanup
set viminfo=%,<800,'10,/50,:100,h,f0,n~/.cache/viminfo

if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
if (has('termguicolors'))
    set termguicolors
endif

" gruvbox Theme
let g:gruvbox_italic = 1
let g:gruvbox_transparent_bg = 1
colorscheme gruvbox

" Allows transparent background
highlight Normal guibg=none
highlight NonText guibg=none

" For commenting and other
let mapleader = ","
