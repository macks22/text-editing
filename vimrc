" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" TODO: this may not be in the correct place.
" It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.

if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax enable

" ================== Plugins with Vundle  =================
" Use Vundle plugin to manage all other plugins
" =========================================================

filetype off               " required by vundle!
set rtp+=~/.vim/bundle/Vundle.vim  " add vundle to runtime path
call vundle#begin()

" Let Vundle manage itself (required!)
Plugin 'VundleVim/Vundle.vim'

" 'Project Drawer' style file explorer using NERDTree
" ---------------------------------------------------
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdtree'
" map startup key to ctrl-n
map <C-n> :NERDTreeTabsToggle<CR>
" open automatically if no files were specified on startup
 autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if only window oepn is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Alternative 'Split Explorer' using CtrlP and vim-vinegar
" --------------------------------------------------------
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-vinegar'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40
let g:ctrlp_show_hidden = 1

" General text editing improvements
" ---------------------------------
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'

" mapping for tagbar toggle
nmap <F2> :TagbarToggle<CR>

" Node/JavaScript stuff
" ---------------------
Plugin 'jelera/vim-javascript-syntax'
Plugin 'moll/vim-node'
Plugin 'briancollins/vim-jst'

" HTML, XML, CSS
Plugin 'skwp/vim-html-escape'
Plugin 'mattn/webapi-vim'
Plugin 'groenewege/vim-less'
Plugin 'digitaltoad/vim-jade'
Plugin 'itspriddle/vim-jquery'

" LaTeX
Plugin 'gerw/vim-latex-suite'
let g:tex_flavor='latex'

" Markdown goodness
"
" force *.md as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

Plugin 'hallison/vim-markdown'
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1

" Pandoc Integration
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-pandoc'

" Live markdown previewing
" Installed manually (see after/ftplugin/markdown)

" Tabbable Snippets
" -----------------
"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate'
"Plugin 'honza/vim-snippets'

" Color schemes to choose from
" ----------------------------
Plugin 'sickill/vim-sunburst'
set bg=dark
"Plugin 'goatslacker/mango.vim'
" color mango
"Plugin 'marcus/vim-mustang'
" color mustang

" Vim SLIME
" ----------------------------
" Plugin 'jpalardy/vim-slime'
" let g:slime_target = "screen"
" let g:slime_paste_file = "$HOME/.slime_paste"
" let g:slime_python_ipython = 1
"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin on    "Load ftplugin.vim in runtimepath
filetype indent on    "Load indent.vim in runtimepath

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Searching ========================

set ignorecase
set smartcase
set incsearch

" ================ Indentation ======================

set autoindent
" set cindent
" set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set wrap           "Wrap lines visually
set textwidth=79   "Turn on physical line wrapping
set fo+=t          "Part of the above
set wrapmargin=0   "Part of the above

" set nowrap       "Don't wrap lines visually
" set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildchar=<Tab>
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Split Screen Navigation ================
" Some useful mappings for navigating between split screens
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" ================ Tab Mapping Settings ========================

nmap <F7> :tabp<CR>
nmap <F8> :tabn<CR>
nmap :e :tabe
