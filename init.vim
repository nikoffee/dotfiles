set termguicolors

if &compatible
  set nocompatible
endif

if has('nvim')
	let s:editor_root = expand("$HOME/.config/nvim")
else
	let s:editor_root = expand("$HOME/.vim")
endif

set runtimepath+=$HOME/.config/nvim/bundle/repos/github.com/Shougo/dein.vim
let s:bundle_dir=expand("$HOME/.config/nvim/bundle")
let s:plugin_dir=s:bundle_dir . '/repos/github.com'

" ======== Python =========
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/local/bin/python2.7'
let g:loaded_python_provider = 1

if dein#load_state(s:plugin_dir)
	call dein#begin(s:plugin_dir)

	call dein#add(s:plugin_dir . '/Shougo/dein.vim')
	call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/vimproc.vim', { 'build': 'make' })
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/echodoc.vim')

	call dein#add('neomake/neomake') " asynchronous syntastic, make per filetype

	call dein#add('jacoborus/tender.vim') " theme & color scheme
	call dein#add('scrooloose/nerdtree') " vim directory navigation
	call dein#add('scrooloose/nerdcommenter')
	call dein#add('vim-airline/vim-airline') " airline plugin for UX
	call dein#add('vim-airline/vim-airline-themes') " themes from airline
	call dein#add('ctrlpvim/ctrlp.vim') " fuzzy finder
	call dein#add('ervandew/supertab')
	call dein#add('SirVer/ultisnips')
	call dein#add('honza/vim-snippets')
  call dein#add('jreybert/vimagit') " git operations inside vim (emacs magit)
	call dein#add('airblade/vim-gitgutter')
	call dein#add('majutsushi/tagbar')
  call dein#add('critiqjo/lldb.nvim')
  call dein#add('neovimhaskell/haskell-vim')
  call dein#add('eagletmt/ghcmod-vim')
  call dein#add('MarcWeber/hasktags')
  call dein#add('eagletmt/neco-ghc')
  call dein#add('idris-hackers/idris-vim') " idris integration
  call dein#add('brooth/far.vim') " search replace utility
  call dein#add('mhinz/vim-grepper')

  call dein#add('janko-m/vim-test')
  call dein#add('skywind3000/asyncrun.vim') " run your tests inside nvim

  call dein#add('tpope/vim-dispatch')
  call dein#add('bling/vim-bufferline')
  call dein#add('rizzatti/dash.vim') " dash integration
  call dein#add('rust-lang/rust.vim') " rust integration
  call dein#add('sebastianmarkow/deoplete-rust') " rust completion
  call dein#add('roxma/nvim-completion-manager')

	call dein#end()
	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
endif

filetype plugin indent on
syntax enable

set t_Co=256
set title
set background=dark
set number
set relativenumber
set history=2500
set showcmd
set noshowmode
set gdefault
set cursorline
set smartcase
set ignorecase
set mouse=a
set showmatch
set nostartofline
set fileencoding=utf-8
set wrap
set linebreak
set list
set lazyredraw
set hidden
set hlsearch
set laststatus=2
set modeline
set magic
set splitright

set noswapfile
set nobackup
set nowb

set foldmethod=syntax

silent !mkdir '~/.config/nvim/backups' > /dev/null 2>&1
set undodir=$HOME/.config/nvim/backups
set undofile

set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*~,*vim/backups*,*cache*,*logs*,*node_modules/**,*DS_Store*,*.gem,log/**,tmp/**,*.png,*.jpg,*.gif

set scrolloff=8
set sidescrolloff=15
set sidescroll=5

nnoremap Q @q
let mapleader=";"

vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy

nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" ===== Neomake ======
" autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_open_list = 2
call neomake#configure#automake('rw', 1000)

" ====== Airline ======
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'

let g:airline_theme='tender'
" let g:airline_theme='badwolf'
" let g:airline_theme='dark theme with powerline symbols'

colorscheme tender
" colorscheme desert " dark bg, light pastel text
" colorscheme elflord " black bg, neon darker text
" colorscheme evening " dark bg, light neon text

" ===== Deoplete =====
let g:deoplete#enable_at_startup = 1

" ==== Git Gutter ====
let g:gitgutter_max_signs = 10000

" ===== TagBar =====
nmap <F8> :TagbarToggle<CR>

    " == Haskell ==
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2

let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

    " == Ruby ==
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

  " == Rust ==
let g:tagbar_type_rust = {
	\ 'ctagstype' : 'rust',
	\ 'kinds' : [
		\'T:types,type definitions',
		\'f:functions,function definitions',
		\'g:enum,enumeration names',
		\'s:structure names',
		\'m:modules,module names',
		\'c:consts,static constants',
		\'t:traits',
		\'i:impls,trait implementations',
	\]
\}


" ===== UltiSnips =====
let g:UltiSnipsExpandTrigger="<S-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let ruby_fold = 1

" ====== Rust ========
let g:rustfmt_autosave = 1
let g:deoplete#sources#rust#racer_binary=expand('$HOME/.cargo/bin/racer')
let g:deoplete#sources#rust#rust_source_path=expand('$HOME/src/github.com/rust/src')
let g:deoplete#sources#rust#show_duplicates=1
let g:deoplete#sources#rust#documentation_max_height=20

" ===== Grepper ======
let g:grepper               = {}
let g:grepper.tools         = ['rg', 'git', 'ag']
let g:grepper.jump          = 1
let g:grepper.next_tool     = '<leader>g'
let g:grepper.simple_prompt = 1
let g:grepper.quickfix      = 0

" ====== Async Run test ======
let g:asyncrun_mode = 0
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
let g:asyncrun_rootmarks = ['.git', '.root', '.bzr', '_darcs', 'build.xml']
let test#strategy = "asyncrun"
nmap <silent><leader>t :TestNearest<CR>
nmap <silent><leader>T :TestFile<CR>

" ======= nerdTREE ======
" Enter nerdtree on no file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" NerdTREE toggle
map <leader>n :NERDTreeToggle<CR>

" ======= Dash App bindings =========
:nmap <silent> <leader>d <Plug>DashSearch

" ===== Far.vim =====
let g:far#source = 'agnvim'

" ===== Ag for Vim =====
let g:ackprg = 'ag --nogroup --nocolor --column'

" ======== CtrlP options =======
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_extensions = ['buffertag', 'undo', 'mixed']

" Indent Custom Config
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set smartindent
set nofoldenable

