""" ~/.config/nvim/init.vim """

" =============================================================================================
" Vundle
" =============================================================================================
set rtp+=~/.vim/bundle/Vundle.vim    " runtime path
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'        " obviously

Plugin 'derekwyatt/vim-scala'
Plugin 'rust-lang/rust.vim'
Plugin 'fatih/vim-go'
Plugin 'sudar/comments.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'shougo/deoplete.nvim'
Plugin 'zchee/deoplete-jedi'
Plugin 'zchee/deoplete-go'
Plugin 'uarun/vim-protobuf'
Plugin 'chrisbra/csv.vim'
Plugin 'neomake/neomake'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'elzr/vim-json'
Plugin 'godoctor/godoctor.vim'
Plugin 'sebdah/vim-delve'

call vundle#end() 


" =============================================================================================
" Basic settings
" =============================================================================================
syntax on

set ai                  " set autoindenting on
set autowrite
set bs=2                " always allow backspacing in insert mode
set clipboard+=unnamed  " Allow to use system clipboard
set cursorline          " draws a horizontal highlight on the line your cursor is currently on
set encoding=utf-8
set expandtab
"set foldmethod=indent
set hidden
set ic                  " ignores case in searches
set incsearch           " searches as you type
set laststatus=2        " Always display a status line at the bottom of the window 
set mouse=a             " Enable mouse in a terminal for all modes
set nohlsearch
set nocompatible        " vim settings rather than vi settings
set nosmartindent
set number
set ruler               " always display cursor
set scrolloff=1         " minimum lines between cursor and window edge
set shell=/bin/zsh      " For TERMINAL mode
set showcmd             " show commands while they're being typed
set showmatch           " shows matching parenthesis, bracket, or brace
set showmode            " displays mode in status line
set showtabline=2
set smartcase           " Make search case sensitive only if it contains uppercase letters
set smartcase           " match 'word' case-insensitive / 'Word' case-sensitive
set splitbelow          " Splitting a window will put the new window below the current
set splitright          " Splitting a window will put the new window right of the current
set textwidth=96        " maximum line width
set title
set ttimeoutlen=50
set wildmenu            " visual autocomplete for command menu
set wrap

" -----------------------------------------------------
" Nathan's key mapping overrides
" -----------------------------------------------------
tnoremap <Esc> <C-\><C-n>   " swtich from TERMINAL mode to NORMAL

" Better split switching
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" -----------------------------------------------------
" fzf (installed via homebrew)
" -----------------------------------------------------
set rtp+=/usr/local/opt/fzf
nmap <C-f> :FZF<CR>

" -----------------------------------------------------
" FileType settings
" -----------------------------------------------------
filetype on
filetype indent on
filetype plugin on

autocmd FileType python setlocal shiftwidth=4 softtabstop=4
autocmd FileType go     setlocal sw=8 tabstop=8
autocmd FileType java   setlocal sw=4 tabstop=4
autocmd FileType scala  setlocal sw=2 tabstop=2
autocmd FileType sh     setlocal sw=2 tabstop=2
autocmd FileType yaml   setlocal sw=2 tabstop=2
autocmd FileType proto  setlocal sw=2 tabstop=2
autocmd FileType html   setlocal sw=4 tabstop=4
autocmd FileType js     setlocal sw=4 tabstop=4


" =============================================================================================
" Background and Colorscheme
" =============================================================================================
colorscheme PaperColor
set background=dark

function! ToggleBackground()
  if &background =~# 'light'
    set background=dark
  else
    set background=light
  endif
endfunction

nmap ;b :call ToggleBackground()<CR>

" Adjust background (light/darkd) based on time of day
if 6 < strftime("%H") && strftime("%H") < 19
  set background=light
else
  set background=dark
endif


" =============================================================================================
" Plugin Settings
" =============================================================================================

" -----------------------------------------------------
" NERDTree settings {{{
" -----------------------------------------------------
" autocmd VimEnter * NERDTree
nmap ;t :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline=0
" }}}

" -----------------------------------------------------
" tagbar settings {{{
" -----------------------------------------------------
nmap ;\ :TagbarToggle<CR>
" }}}

" -----------------------------------------------------
" Ultisnips settings {{{
" -----------------------------------------------------
let g:UltiSnipsUsePythonVersion=3
let g:UltiSnipsExpandTrigger = "<C-l>"
"}}}
"
" -----------------------------------------------------
" deoplete settings {{{
" -----------------------------------------------------
set completeopt+=noinsert
set completeopt+=noselect

let g:python3_host_prog  = '/Library/Frameworks/Python.framework/Versions/3.5/bin/python3'
let g:python3_host_skip_check = 1

let g:deoplete#enable_at_startup = 1

" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
"let g:deoplete#sources#go#json_directory = '/path/to/data_dir'

" deoplete-python settings
" }}}


" -----------------------------------------------------
" vim-json settings
" -----------------------------------------------------
autocmd FileType json setlocal foldmethod=syntax
" }}}

" -----------------------------------------------------
" vim-go settings
" -----------------------------------------------------
let g:go_alternate_mode = "vsplit"
let g:go_add_tags_transform="snakecase"
" More accurate than godoc but too slow
" let g:go_info_mode="guru"
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
" let g:go_updatetime=1500
let g:go_fmt_command = "goimports" " use goimports rather than gofmt on save
let g:go_fmt_fail_silently=1
let g:go_gocode_unimported_packages = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_fields = 1
let g:go_highlight_operators = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_interfaces = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_types = 1
" let g:go_highlight_extra_types = 1
let g:go_list_type = "quickfix"
let g:go_snippet_case_type = "camelcase"
" let g:go_term_enabled=1 " run commands in a terminal rather than the quickfix window
" let g:go_term_mode="split"
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
autocmd FileType go nmap <buffer> <leader>e <plug>(go-rename)
autocmd FileType go nmap <buffer> <leader>i <plug>(go-info)
autocmd FileType go nmap <buffer> <leader>d <plug>(go-describe)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>f :GoDeclsDir<CR>
autocmd FileType go nmap <Leader>s :GoDefStack<CR>
autocmd FileType go nmap <Leader>p :GoChannelPeers<CR>
" N.B. 'K' in normal mode runs :GoDoc

nnoremap <leader>a :cclose<CR>

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" }}}

" -----------------------------------------------------
" Neomake settings {{{
" -----------------------------------------------------
autocmd! BufWritePost * Neomake
let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
let g:neomake_go_gometalinter_maker = {
  \ 'args': [
  \   '--tests',
  \   '--enable-gc',
  \   '--concurrency=3',
  \   '--fast',
  \   '-D', 'aligncheck',
  \   '-D', 'dupl',
  \   '-D', 'gocyclo',
  \   '-D', 'gotype',
  \   '-E', 'errcheck',
  \   '-E', 'misspell',
  \   '-E', 'unused',
  \   '%:p:h',
  \ ],
  \ 'append_file': 0,
  \ 'errorformat':
  \   '%E%f:%l:%c:%trror: %m,' .
  \   '%W%f:%l:%c:%tarning: %m,' .
  \   '%E%f:%l::%trror: %m,' .
  \   '%W%f:%l::%tarning: %m'
  \ }
" }}}


" -----------------------------------------------------
" csv-vim settings {{{
" -----------------------------------------------------
let b:csv_headerline = 1
" }}}
