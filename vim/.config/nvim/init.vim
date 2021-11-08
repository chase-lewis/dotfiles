"
" Vundle
"

set nocompatible
set rtp+=~/.set nocompatible      " be iMproved, required
filetype off                      " required
set rtp+=~/.vim/bundle/Vundle.vim " include Vundle
call vundle#begin()               " initialize

Plugin 'VundleVim/Vundle.vim'     " plugin manager, required
Plugin 'tpope/vim-fugitive'       " git wrapper
Plugin 'scrooloose/nerdtree'      " file explorer, :help NerdTreeMappings
Plugin 'tpope/vim-surround'       " wrap in quotes/brackets, :help surround
Plugin 'kien/ctrlp.vim'           " fuzzy file finder, :help ctrlp-mappings
Plugin 'scrooloose/nerdcommenter' " commenter, :help :NERDCommenter
Plugin 'ervandew/supertab'        " easier completion (just tab)
Plugin 'airblade/vim-gitgutter'   " Add git changes to gutter
Plugin 'tpope/vim-sleuth'         " Auto indent-detection
Plugin 'vimwiki/vimwiki'          " Wiki software for notes
Plugin 'majutsushi/tagbar'        " Side bar for tags
Plugin 'sjl/gundo.vim'            " Side bar for undo tree
Plugin 'jamessan/vim-gnupg'       " Edit gpg files in vim
Plugin 'ledger/vim-ledger'        " Easy ledger editing
"Plugin 'lervag/vimtex'
"Plugin 'benekastah/neomake'
"Plugin 'valloric/youcompleteme'
"Plugin 'vim-syntastic/syntastic'

call vundle#end()            " required, plugins must be added before this line
filetype plugin indent on    " required

" Vundle commands, :h vundle for more
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

"
" General
"
set timeoutlen=1000 ttimeoutlen=0 " remove escape delays
syntax enable
set showmatch
set matchtime=2
set lazyredraw
set hidden


"
" Line numbering
"
set relativenumber
au FocusLost * : set number
au FocusGained * : set relativenumber
autocmd InsertEnter * : set number
autocmd InsertLeave * : set relativenumber


"
" Indentation
"
set autoindent
set cindent " c-like indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab


"
" Folding
"
set foldenable
set foldlevelstart=11
set foldmethod=syntax
set foldnestmax=10


"
" Command line completion
"
set wildmenu
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.swp,*.bak,*.pyc,*.class


"
" Search
"
set incsearch " Search while typing
set hlsearch  " Highlight search results
set ignorecase
set smartcase

"
" Splits
"
set splitbelow
set splitright
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"
" Supertab
"
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"

"
" CtrlP
"
let g:ctrlp_map = '<c-p>'


"
" Nerdtree
"
map <C-n> :NERDTreeToggle<CR>

"
" Gundo
"
nnoremap <leader>u :GundoToggle<CR>

"
" VimWiki
"
let wiki = {}
let wiki.path = '~/Documents/notes'
let wiki.syntax = 'markdown'
let wiki.ext = '.md'
let wiki.auto_tags = 1
let wiki.auto_diary_index = 1
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'sh': 'sh', 'java': 'java'}
let g:vimwiki_list = [wiki]
au BufNewFile ~/Documents/notes/diary/*.md :0r ~/.vim/templates/diary.md | exe "1s/<vwiki-date>/" . strftime("%Y-%m-%d") . "/"


"
" Ledger
"
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
au FileType ledger noremap { ?^\d<CR>
au FileType ledger noremap } /^\d<CR>
let g:ledger_maxwidth = 120
let g:ledger_fold_blanks = 1
let g:ledger_align_at = 60
function! LedgerSort()
    :silent %s/\s\+$//e
    :silent %s/^\s\+/    /e
    %! perl -n00 -e 'push @a, $_; END { print sort @a }'
    :%LedgerAlign
endfunction
command! LedgerSort call LedgerSort()
au FileType ledger nnoremap <silent> <leader>lf :LedgerSort<CR>
au FileType ledger nnoremap <silent> <leader>le :call ledger#entry()<CR>:call ledger#transaction_state_set(line('.'), '*')<CR>:%LedgerAlign<CR>:echo 'banana'<CR>
au FileType ledger nnoremap <silent> <leader>lt :call ledger#transaction_state_toggle(line('.'), ' *?!')<CR>


"
" Status bar
"
set laststatus=2 " enable status

