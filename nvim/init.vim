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
set runtimepath+=/usr/local/opt/fzf
let s:bundle_dir=expand("$HOME/.cache/dein")

" ======== Python =========
let g:python3_host_prog = '/usr/local/opt/python/libexec/bin/python'
let g:loaded_python_provider = 1
let g:python2_host_prog = '/usr/local/opt/python@2/bin/python'

if dein#load_state(s:bundle_dir)
  call dein#begin(s:bundle_dir)

  call dein#add(s:bundle_dir . '/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', { 'build': 'make' })
  call dein#add('Shougo/echodoc.vim')

""" Syntax Highlighting
  call dein#add('othree/yajs.vim') " Better js lexical highlighting
  call dein#add('rust-lang/rust.vim') " rust integration

""" Auto completion & Linting
  call dein#add('sheerun/vim-polyglot') " pack of ~150 languages
  call dein#add('tpope/vim-endwise') " ruby end autocompletion

""" Language Client/Servers related
call dein#add('neoclide/coc.nvim', {'merge':0, 'build': 'yarn install --frozen-lockfile'})

""" IDE feature & management
  call dein#add('majutsushi/tagbar') " project structure via tags
  call dein#add('ludovicchabant/vim-gutentags') " ctags management
  call dein#add('scrooloose/nerdtree') " vim directory navigation
  call dein#add('scrooloose/nerdcommenter') " hotkey for commenting code
  call dein#add('brooth/far.vim') " search replace utility
  call dein#add('mhinz/vim-grepper') " enhanced grepping (using chosen utility: ag, rip grep)
  call dein#add('ctrlpvim/ctrlp.vim') " fuzzy finder / file nav
"  call dein#add('nixprime/cpsm') " faster matcher for ctrlp
  call dein#add('rizzatti/dash.vim') " dash integration
  call dein#add('janko/vim-test') " test from neovim

""" Source code Management
  call dein#add('tpope/vim-fugitive') " control Git inside neovim

""" Vim UI
  call dein#add('mhartington/oceanic-next') " Oceanic Next colorscheme
  call dein#add('vim-airline/vim-airline') " airline plugin for UX
  call dein#add('vim-airline/vim-airline-themes') " themes from airline
  call dein#add('airblade/vim-gitgutter') " git UI for diff changes in the gutter
  call dein#add('bling/vim-bufferline') " show open buffers with airline
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

" LANGUAGE SPECIFIC autocmd -- Folding/Indent
autocmd FileType ruby,haml,eruby,yaml,html,sass,cucumber set expandtab ai smartindent sw=2 sts=2 et
autocmd FileType python set sw=4 sts=4 et
autocmd! FileType javascript set sw=2 sts=2 expandtab autoindent smartindent nocindent
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" OTHERS

nnoremap Q @q
let mapleader=";"

" Copy visual selection, Paste
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy

nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Previous or Next buffer (move around)
map <Leader>[ :bprevious<CR>
map <Leader>] :bnext<CR>

" ====== Airline ======

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#formatter = 'default'
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

" ===== Grepper ======
cnoremap <c-n> <down>
cnoremap <c-p> <up>

nnoremap <leader>g :Grepper <cr>
nnoremap <leader>G :Grepper -tool ag -cword -noprompt<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

let g:grepper               = {
      \ 'tools': ['rg', 'git', 'ag'],
      \ 'jump': 1,
      \ 'highlight': 1,
      \ 'dir': 'repo,file',
      \ 'next_tool': '<leader>g',
      \ 'simple_prompt': 1,
      \ 'qickfix': 1,
      \ 'stop': 2000,
      \}
"let command! Todo Grepper -tool git -query -E '(TODO|FIXME|XXX):'

" ======= Dash App bindings =========
:nmap <silent> <leader>d <Plug>DashSearch

" ===== Far.vim =====
let g:far#source = 'agnvim'

" ===== Ag for Vim =====
let g:ackprg = 'ag --nogroup --nocolor --column'

" ======== CtrlP options =======
let g:ctrlp_user_command = {
      \'types': {
        \ 1: ['.git', 'cd %s && git ls-files -co --exclude-standard'],
        \},
      \ 'fallback': 'fd --type f --color=never "" %s',
      \}
let g:ctrlp_extensions = ['buffertag', 'undo', 'mixed']
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:15,results:30'
" let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 'ra'

" ======= CPSM options for CTRLP ========
" let g:cpsm_match_empty_query = 0
" let g:cpsm_highlight_mode = "detailed"

"""" ==== DestroyAllSoftware
" type current dir path
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Manage win size
set winwidth=84
set winheight=5
set winminheight=5
set winheight=30

" Only Delete Buffer, keep layout.
function! DeleteBufferKeepLayout()
  :lclose
  :b #
  :bd #
endfunction
nnoremap <silent> <leader>q :call DeleteBufferKeepLayout()<cr>

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
nmap <space>rn :call RenameFile()<cr>

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


" Auto reload nvim configs on change
if has ('autocmd') " Remain compatible with earlier versions
 augroup nvim_init     " Source nvim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif

""""""""""""""""""""
" Gutentags Configs
""""""""""""""""""""
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_plus_switch = 1
let g:gutentags_modules = ['ctags', 'gtags_cscope']

""""""""""""""""""""
" NERDCommenter
""""""""""""""""""""
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

"""""""""""""""""""""
" coc Language Server Protocol Configs
"""""""""""""""""""""
" Better message display
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes


autocmd FileType json syntax match Comment +\/\/.\+$+
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Backspace function
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"""""""""""""""""""""
" echodoc plugin configs
"""""""""""""""""""""
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
highlight link EchoDocFloat Pmenu

""""""""""""""""""""""
" vim-test
""""""""""""""""""""""
let test#strategy = "vimproc"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
