set encoding=UTF-8

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" autocomplete
" Plug 'ajh17/VimCompletesMe'

" palenight theme
Plug 'drewtempelmeyer/palenight.vim'

" airline statusline
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1

" git gutter
Plug 'airblade/vim-gitgutter'

" git buffer list
Plug 'bling/vim-bufferline'

" vim icons
Plug 'ryanoasis/vim-devicons'

" tree explorer with git support
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" tree config
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" linting
Plug 'dense-analysis/ale'

" Initialize plugin system
call plug#end()

" basic indent and syntax highlighting options
filetype plugin indent on
syntax on

" show existing tab with 4 spaces width
set expandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4
" useful backspace in insert mode
set backspace=indent,eol,start

set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned

" show these bad boys
set list
set listchars=tab:»-,extends:›,precedes:‹,nbsp:·,trail:·

" use palenight colorscheme
set background=dark
silent! colorscheme palenight

" italics
let g:palenight_terminal_italics=1

" true colors
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
