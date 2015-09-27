set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
Plugin 'tpope/vim-fugitive'
Plugin 'elixir-lang/vim-elixir'
Plugin 'mattreduce/vim-mix'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tomasr/molokai'
Plugin 'ervandew/supertab'
Plugin 'mileszs/ack.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tomtom/tcomment_vim'
Plugin 'groenewege/vim-less'
Plugin 'kchmck/vim-coffee-script'
Plugin 'fatih/vim-go'
Plugin 'othree/yajs'
Plugin 'SirVer/ultisnips'
Plugin 'lambdatoast/elm.vim'

set iskeyword-=.

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

autocmd BufWritePost .vimrc source %

let mapleader = ","

au BufRead,BufNewFile *.md set filetype=markdown

nmap <leader>v :tabedit $MYVIMRC<CR>

nmap <leader>n :NERDTreeTabsToggle<CR>
nmap <leader>N :NERDTreeFind<CR>
nmap <leader>b :CtrlPBuffer<CR>

set splitbelow
set splitright

set showmatch

set t_Co=256

syntax enable
" set background=light
" colorscheme solarized

set background=dark
colorscheme molokai

set number
set cursorline
set linebreak

set scrolloff=4
set scrolljump=5

set laststatus=2

let g:airline_powerline_fonts = 1
set encoding=utf-8
set guifont=Inconsolata\ for\ Powerline:h15

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/](node_modules|vendor\/ruby|(\.(git|hg|svn)))$'
let g:ctrlp_max_files=0

" Tabs and spaces                                              {{{1
" -----------------------------------------------------------------

" General
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set tabstop=4

" Lookbook
" set noexpandtab
" set copyindent
" set preserveindent
" set softtabstop=0
" set shiftwidth=4
" set tabstop=4

" Auto indent?
" set smartindent
" set autoindent
if has("autocmd")
  filetype plugin indent on
endif
" set cindent

" Call strip trailing whitespaces as a command
command! StripTrailingWhitespace call s:StripTrailingWhitespace()

function! s:StripTrailingWhitespace()
  " Save last search and cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do it!
  %s/\s\+$//e
  " Clean up by restoring the saved search and cursor
  let @/=_s
  call cursor(l, c)
endfunction

map <leader>w :StripTrailingWhitespace<CR>

autocmd BufWritePre * :StripTrailingWhitespace

au BufRead,BufNewFile *.ino set filetype=cpp
au BufRead,BufNewFile *.rabl set filetype=ruby
au BufRead,BufNewFile *.iced set filetype=coffee
au BufRead,BufNewFile *.sbt set filetype=scala
au BufRead,BufNewFile *.ejs set filetype=html
au BufRead,BufNewFile *.gss set filetype=css

autocmd Filetype go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
" autocmd Filetype javascript setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
" autocmd Filetype jsx setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

" Vagrantfile
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby

set spell
