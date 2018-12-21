set nocompatible
filetype off

set rtp+=~/.set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ervandew/supertab'
Plugin 'airblade/vim-gitgutter'
Plugin 'raimondi/delimitmate'
Plugin 'benekastah/neomake'
Plugin 'tpope/vim-sleuth'
Plugin 'lervag/vimtex'

"Airline and fonts:
"set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h20
set laststatus=2

"Remove escape delays
set timeoutlen=1000 ttimeoutlen=0

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"Line numbering functionality:
set relativenumber
au FocusLost * : set number
au FocusGained * : set relativenumber
autocmd InsertEnter * : set number
autocmd InsertLeave * : set relativenumber

"Syntax enable
syntax enable

"set tabsize
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"UI config
filetype indent on
set wildmenu

"searching changes
set incsearch
set hlsearch

"CtrlP changes
let g:ctrlp_map = '<c-p>'

"Nerdtree changes
map <C-n> :NERDTreeToggle<CR>
