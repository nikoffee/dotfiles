set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'rizzatti/dash.vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'edkolev/tmuxline.vim'
Plugin 'tpope/vim-sensible'
Plugin 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list=1
Plugin 'dag/vim2hs'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/vimproc'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-endwise'
Plugin 'vim-javascript'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" All of your Plugins must be added before the following line
call vundle#end()

filetype plugin indent on
syntax on
set background=dark

" Airline
set laststatus=2
set guifont=Monaco\ for\ Powerline
let g:airline_powerline_fonts=1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline_theme='molokai'

" Theme
set t_Co=256
let g:powerline_theme_overrides=''
syntax enable
autocmd ColorScheme * highlight clear SignColumn

set tabstop=2
set expandtab

set cursorline
set ruler

" Display command line's tab complete options as a menu
set wildmenu

" Whitespace hightlight
autocmd BufWritePre *.py,*.java,*.rb,*.coffee,*.rake,*.js :%s/\s\+$//e
set fileformat=unix
highlight ExtraWhitespace ctermbg=red guibg=red


" Search highlighting
set hlsearch
" Search is case insensitive
set ignorecase
" Search switches to case sensitive when using CAPS
set smartcase
" Relative line numbers
set relativenumber

" Fold code based on syntax defined folding rules
set foldmethod=syntax
set foldnestmax=3
set nofoldenable

" Ruby
autocmd Filetype ruby set shiftwidth=2|set softtabstop=2|set expandtab

" Yaml
autocmd Filetype yaml set shiftwidth=2|set softtabstop=2|set expandtab

" Python
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab

" Java
autocmd FileType java set tabstop=4|set shiftwidth=4|set expandtab

" Present dialog if unsaved changes
set confirm

set mouse=a

set colorcolumn=120
set cmdheight=2
set encoding=utf-8

set backupdir=~/.cache/vim//
set directory=~/.cache/vim/swap//

set history=2500

set clipboard=unnamed

let g:airline#extensions#tabline#enabled = 1

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }


