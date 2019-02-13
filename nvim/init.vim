set termguicolors

if &compatible
  set nocompatible
endif

if has('nvim')
  let s:editor_root = expand("$HOME/.config/nvim")
else
  let s:editor_root = expand("$HOME/.vim")
endif

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim
let s:bundle_dir=expand("$HOME/.cache/dein")

" ======== Python =========
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/local/bin/python2'

if dein#load_state(s:bundle_dir)
  call dein#begin(s:bundle_dir)

  call dein#add(s:bundle_dir . '/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', { 'build': 'make' })
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/echodoc.vim')

  call dein#add('mhartington/oceanic-next') " Oceanic Next colorscheme
  call dein#add('sheerun/vim-polyglot') " pack of ~150 languages
  call dein#add('othree/yajs.vim') " Better js lexical highlighting

  call dein#add('w0rp/ale') " Async Lint Engine
  call dein#add('autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' })
  call dein#add('ncm2/ncm2')
  call dein#add('ncm2/ncm2-gtags')
  call dein#add('ncm2/ncm2-syntax')

  call dein#add('scrooloose/nerdtree') " vim directory navigation
  call dein#add('scrooloose/nerdcommenter') " hotkey for commenting code

  call dein#add('vim-airline/vim-airline') " airline plugin for UX
  call dein#add('vim-airline/vim-airline-themes') " themes from airline

  call dein#add('brooth/far.vim') " search replace utility
  call dein#add('ctrlpvim/ctrlp.vim') " fuzzy finder / file nav
"  call dein#add('nixprime/cpsm') " faster matcher for ctrlp

  call dein#add('airblade/vim-gitgutter')
  call dein#add('majutsushi/tagbar') " project structure via tags
  call dein#add('tpope/vim-fugitive') " needed for airline branch
  call dein#add('mhinz/vim-grepper')

  call dein#add('janko-m/vim-test')
  call dein#add('skywind3000/asyncrun.vim') " run your tests inside nvim

  call dein#add('tpope/vim-dispatch')

  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-bundler')

  call dein#add('bling/vim-bufferline')

  call dein#add('rizzatti/dash.vim') " dash integration

  call dein#add('rust-lang/rust.vim') " rust integration

  call dein#add('ryanoasis/vim-devicons') " Vim Icons - Always load last
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

set t_Co=256
set encoding=UTF-8
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
set smartindent
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

silent! helptags ALL

autocmd FileType ruby,haml,eruby,yaml,html,sass,cucumber set expandtab ai smartindent sw=2 sts=2 et
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

" ====== Airline ======

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1

let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Location'

let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 0
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]

let g:airline#extensions#whitespace#show_message = 1

" let g:airline#extensions#neomake#enabled = 1

" ====== Looks and FEELS =======
" let g:airline_theme='luna'
let g:airline_theme='base16_spacemacs'
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

colorscheme OceanicNext

" ==== Git Gutter ====
let g:gitgutter_max_signs = 10000

" ===== TagBar =====
nmap <F8> :TagbarToggle<CR>

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


" ===== Ruby ======
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
let g:asyncrun_rootmarks = ['.git', '.root', '.bzr', '_darcs', 'build.xml']
let test#strategy = "asyncrun"
let g:asyncrun_open = 12
nmap <silent><leader>t :TestNearest<CR>
nmap <silent><leader>T :TestFile<CR>

" ======= Dash App bindings =========
:nmap <silent> <leader>d <Plug>DashSearch

" ===== Far.vim =====
let g:far#source = 'agnvim'

" ===== Ag for Vim =====
let g:ackprg = 'ag --nogroup --nocolor --column'

" ======== CtrlP options =======
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_extensions = ['buffertag', 'undo', 'mixed']
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:15'
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = 'fd --type f --color=never "" %s'

" ======= CPSM options for CTRLP ========
let g:cpsm_match_empty_query = 0
let g:cpsm_highlight_mode = "detailed"

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

"autocmd BufWinEnter quickfix nnoremap <silent> <buffer>
            "\   q :cclose<cr>:lclose<cr>
"autocmd BufEnter * if (winnr('$') == 1 && &buftype ==# 'quickfix' ) |
            "\   bd|
            "\   q | endif

set completeopt=noinsert,menuone,noselect
"autocmd BufEnter * call ncm2#enable_for_buffer()
set shortmess+=c
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Auto reload nvim configs on change
if has ('autocmd') " Remain compatible with earlier versions
 augroup nvim_init     " Source nvim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'ruby': ['rubocop'],
\   'rust': ['rustfmt'],
\   'coffeescript': ['coffee', 'coffeelint'],
\   'erb': ['erb', 'erubi'],
\   'graphql': ['eslint', 'gqlint', 'prettier'],
\   'html': ['prettier'],
\   'idris': ['idris'],
\   'json': ['prettier'],
\   'markdown': ['prettier'],
\   'yaml': ['prettier'],
\}

let g:airline#extensions#ale#enabled = 1
let g:ale_close_preview_on_insert = 1
let g:ale_completion_enabled = 1
let g:ale_ruby_solargraph_executable = 'solargraph'
let g:ale_cursor_detail = 1
let g:ale_fix_on_save = 1
let g:ale_enabled = 1

""""""""""""""""""""""""""""""""""""""""""""
" LanguageClient-neovim
""""""""""""""""""""""""""""""""""""""""""""
let g:LanguageClient_serverCommands = {
    \ 'ruby': ['tcp://localhost:7658'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['/opt/javascript-typescript-langserver/lib/language-server-stdio.js'],
    \ }

" Stop restarting Solargraph when restarting neovim
" let g:LanguageClient_autoStop = 0

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
