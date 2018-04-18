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
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-bundler')
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
set history=10000
set showcmd
set noshowmode
set gdefault
set cursorline
set smartcase
set ignorecase smartcase
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
set autoindent
set t_ti= t_te=
set backspace=indent,eol,start
set nojoinspaces
set autoread

set noswapfile
set nobackup
set nowb

set foldmethod=syntax

silent !mkdir '~/.config/nvim/backups' > /dev/null 2>&1
set undodir=$HOME/.config/nvim/backups
set undofile

set wildmenu
set wildmode=longest,list
set wildignore=*.o,*.obj,*~,*vim/backups*,*cache*,*logs*,*node_modules/**,*DS_Store*,*.gem,log/**,tmp/**,*.png,*.jpg,*.gif

set scrolloff=5
set sidescrolloff=15
set sidescroll=5

autocmd FileType ruby,haml,eruby,yaml,html,sass,cucumber set ai sw=2 sts=2 et
autocmd FileType python set sw=4 sts=4 et
autocmd! FileType javascript set sw=2 sts=2 expandtab autoindent smartindent nocindent

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

map <Leader>[ :bprevious<CR>
map <Leader>] :bnext<CR>

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
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#tag#cache_limit_size = 20000000
let g:deoplete#max_list = 30
let g:deoplete#enable_camel_case = 1
let g:deoplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::'
\}

" use tab
imap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}


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
nnoremap <leader>g :Grepper -tool rg<cr>
nnoremap <leader>G :Grepper -tool rg -buffers<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

let g:grepper               = {}
let g:grepper.tools         = ['rg', 'git', 'ag']
let g:grepper.jump          = 1
let g:grepper.next_tool     = '<leader>g'
let g:grepper.simple_prompt = 1
let g:grepper.quickfix      = 1

" ====== Async Run test ======
let g:asyncrun_mode = 0
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
let g:asyncrun_rootmarks = ['.git', '.root', '.bzr', '_darcs', 'build.xml']
let test#strategy = "asyncrun"
let g:asyncrun_open = 12
nmap <silent><leader>t :TestNearest<CR>
nmap <silent><leader>T :TestFile<CR>

" ======= nerdTREE ======
let g:NERDTreeShowHidden = 1
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
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:30'

"""" ==== DestroyAllSoftware
" type current dir path
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Manage win size
set winwidth=84
set winheight=5
set winminheight=5
set winheight=30

" Show Rails Routes
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" quick switch between last 2 files
nnoremap <leader><leader> <c-^>
" Align selected lines
vnoremap <leader>ll :!align<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

" Indent Custom Config
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set nofoldenable

autocmd BufWinEnter quickfix nnoremap <silent> <buffer>
            \   q :cclose<cr>:lclose<cr>
autocmd BufEnter * if (winnr('$') == 1 && &buftype ==# 'quickfix' ) |
            \   bd|
            \   q | endif
