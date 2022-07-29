" Vundle plugin manager section
" =================================================================

" turn off vi backwards compatibility
set nocompatible
" turn off automatic filetype detection
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" nerdtree plugin
Plugin 'scrooloose/nerdtree'
" smart indentation for python (fixes some autoindent cons)
Plugin 'vim-scripts/indentpython.vim'
" check python syntax on each save
Plugin 'vim-syntastic/syntastic'
" check PEP8 via flake8 on each save
Plugin 'nvie/vim-flake8'
" colorscheme ZenBurn
Plugin 'jnurmine/Zenburn'
" colorscheme solarized light
Plugin 'altercation/vim-colors-solarized'
" markdown syntax highlightning
Plugin 'gabrielelana/vim-markdown'
" preview markdown files 
Plugin 'iamcco/markdown-preview.nvim'
" autosave plugin
Plugin '907th/vim-auto-save'

" all plugins should be placed before this line
call vundle#end()
filetype plugin indent on
" ==================================================================

" set UTF-8 encoding
set encoding=utf-8

" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
" set showmatch

" enable all Python syntax highlighting features
let python_highlight_all = 1

" highlight all search results
set hlsearch    

" do case insensitive search
set ignorecase  

" show incremental search results as you type
set incsearch

" this unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" no swapfile created
set noswapfile

" ignore unwanted files
let NERDTreeIgnore = [ '__pycache__', '\.pyc$', '\.o$', '\.swp',  '*\.swp',  'node_modules/' ]

" show hidden files
let NERDTreeShowHidden=1

" automatically start nerdtree when vim start 
autocmd VimEnter * NERDTree
" also when new buffer or tab is opened
autocmd BufWinEnter * NERDTreeMirror
" place the cursor in newly opened file instead of tree view pane
autocmd VimEnter * wincmd w
" quit nerdtree if it's the only pane left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Python specific settings
" =============================================
" PEP8 indentation settings for python files
au Filetype python
    \ setlocal tabstop=4
    \ | setlocal softtabstop=4
    \ | setlocal textwidth=90
    \ | setlocal fileformat=unix

" enable python syntax
let python_highlight_all=1
syntax on
colors zenburn
"python with virtualenv support
py3 << EOF
import os
import sys
import site

if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate = os.path.join(project_base_dir, 'bin/activate')
    __file__ = activate
    abs_file = os.path.abspath(__file__)

    bin_dir = os.path.dirname(abs_file)
    base = bin_dir[: -len("__BIN_NAME__") - 1]  # strip away the bin part from the __file__, plus the path separator

    # prepend bin to PATH (this file is inside the bin directory)
    os.environ["PATH"] = os.pathsep.join([bin_dir] + os.environ.get("PATH", "").split(os.pathsep))
    os.environ["VIRTUAL_ENV"] = base  # virtual env is right above bin directory

    # add the virtual environments libraries to the host python import mechanism
    prev_length = len(sys.path)
    for lib in "__LIB_FOLDERS__".split(os.pathsep):
        path = os.path.realpath(os.path.join(bin_dir, lib))
        site.addsitedir(path)
    sys.path[:] = sys.path[prev_length:] + sys.path[0:prev_length]

    sys.real_prefix = sys.prefix
    sys.prefix = base
EOF
" =============================================

" Markdown specific settings
" =============================================
au Filetype markdown set textwidth=90
" =============================================

" markdown_preview plugin settings
" =============================================
" do not start preview automatically when seeing .md file 
let g:mkdp_auto_start = 0
" =============================================

