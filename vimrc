call pathogen#infect()
call pathogen#helptags()

if has("autocmd")
  autocmd bufwritepost vimrc source $MYVIMRC
endif

" Enable matchit
runtime macros/matchit.vim
set nocompatible

set t_Co=256

" Leader
let mapleader = ","
let g:mapleader = ","

" Misc. file types
au BufRead,BufNewFile *.md set filetype=markdown

nmap <leader>v :tabedit $MYVIMRC<CR>

:command Q q
:command W w

" jj in insert mode to get to normal mode
:imap jj <Esc>

" Set the command height to 2 lines
set cmdheight=2

" Always show the status line
set laststatus=2

" Allow me to switch buffers if my buffer has changes
set hidden

set splitbelow
set splitright

" Search options
:nnoremap <silent> <space> :nohlsearch<Bar>:echo<CR>

" Stealing some guy's status line
" since I don't know the formatting
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]

" Causes the cursor to briefly jump back
" to a brace/paren/etc. match whenever
" you type a closing one.
set showmatch

" Toggle NERDTree
" map <leader>t :NERDTreeToggle<CR>

nmap <silent> <Leader>t :CommandT<CR>
nmap <silent> <Leader>b :CommandTBuffer<CR>

" Git status
map <leader>g !git status<CR>

" Colors and Syntax                                            {{{1
" -----------------------------------------------------------------

" Turn syntax hightlighting on
syntax on
colors jellybeans_custom

" Display an incomplete cmmand in the lower right
set showcmd

" Scrolling margin and number of lines when leaving screen
set scrolloff=4
set scrolljump=5

" Highlight the cursor line
set cursorline

" Line numbers, fool!
set number
" Toggle line numbers with leader-n
map <silent> <leader>n :set number!<CR>

" Make :w!! save the file as sudo
" (in case you forget)
cmap w!! %w !sudo tee % > /dev/null

" Don't split words if a linebreak is required
set linebreak

" Tabs and spaces                                              {{{1
" -----------------------------------------------------------------

set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
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
