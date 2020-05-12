" Soumya Kumar's vimrc
" derived from Dave Walkers
" derived from Matt Campbells
" derived from Giles Francis Hall

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Bundle 'pangloss/vim-javascript'
Plugin '2072/PHP-Indenting-for-VIm'
Plugin 'git://github.com/nathanaelkane/vim-indent-guides.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'leafgarland/typescript-vim'

call vundle#end()
filetype plugin indent on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" Set airline theme
let g:airline_powerline_fonts = 1
let g:airline_theme = 'molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

set hidden
nmap <leader>T :enew<cr>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

set list
set listchars=tab:->

" General environ options
set backspace=indent,start,eol
set ruler							" Show cursor location info
set smartindent						" Always Autoindent
set showcmd							" Show Partial Commands
set whichwrap=b,s,h,l,<,>,[,]		" Set the wrapping characters
set encoding=utf-8					" No more ANSI encodings
set fileencoding=utf-8				" No more ANSI encodings
set nobackup						" Don't bother with backup files
set title							" Show the title
set linebreak						" Show linebreaks
set showbreak=>						" Use '>' character for line breaks
set number							" Show line numbers
set numberwidth=5					" Default to 5 number spaces
set incsearch						" Use incremental searching
set hlsearch						" Use Highlighting
set ignorecase						" Case insensitive matching
set smartcase						" Case sensitive matching if caps in search string
set synmaxcol=5000					" Really long line syntax highlighting
set showmatch						" Show matching brackets
set novisualbell					" No bells
set wildmenu						" turn on command line completion wild style
set wildmode=list:longest			" turn on wild mode huge list
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
set foldcolumn=3

set cinoptions=l1

syntax on							" Syntax highlighting

set viminfo='10,\"100,:20,%,n~/.viminfo

" Visual Stuff
set background=dark					" Use a dark background
set showcmd							" Show info in the ruler

"set tabstop=4
"set shiftwidth=4

" Persistent undo
set undodir=$HOME/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000

" set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\
set listchars=tab:·>

" Status Line
set laststatus=2
set statusline=%f[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%*%=%c,%l/%L\ %P

if !has("gui_running")
    set term=xterm-256color
endif

let PHP_vintage_case_default_indent = 1

" Tab info, all spaces, </3 PSR2
" set expandtab
" let g:indent_guides_auto_colors = 0
" hi IndentGuidesOdd  ctermbg=blue
" hi IndentGuidesEven ctermbg=darkblue
" let g:indent_guides_start_level = 2
" let g:indent_guides_guide_size = 1
" let g:indent_guides_enable_on_vim_startup = 1

" Remap movement keys to go through multi-line lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Map FuncKeys to PHPFolding
map <F5> <Esc>:EnableFastPHPFolds<Cr>
map <F6> <Esc>:EnablePHPFolds<Cr>
map <F7> <Esc>:DisablePHPFolds<Cr>

setlocal foldmethod=manual

nnoremap <space> za
vnoremap <space> za

nnoremap <c-]> :tjump <C-r><C-w><Cr>
vnoremap <c-]> :tjump <C-r><C-w><Cr>

nnoremap <c-w><c-]> :stjump <C-r><C-w><Cr>
vnoremap <c-w><c-]> :stjump <C-r><C-w><Cr>

nnoremap <c-w>] :stjump <C-r><C-w><Cr>
vnoremap <c-w>] :stjump <C-r><C-w><Cr>

" Fix up some filetypes
au BufNewFile,BufRead *.inc set filetype=php
au BufNewFile,BufRead *.class set filetype=php
au BufNewFile,BufRead *.js set filetype=javascript
au BufNewFile,BufRead *.tpl set filetype=smarty
au BufNewFile,BufRead *.tmpl set filetype=smarty

autocmd BufNewFile,FileType smarty  set smartindent
autocmd BufNewFile,FileType php  set smartindent
autocmd BufNewFile,FileType perl set smartindent

autocmd BufReadPost *
            \ if line("'\"") > 0 && line ("'\"") <= line("$") |
            \   exe "normal! g'\"" |
            \ endif

" glorious justification!  gq for the masses.
nnoremap <C-J> gqap
nnoremap <silent> <F8> :TlistToggle<CR>

" Highlight extra spaces or tabs in red.
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/

" CTAGz
" explain the commands
" -f (output)
" --langmap (map .inc and .class files as PHP)
" -h (treat .php .inc .class as "header" files)
" -R (Recurse)
" --totals (print totals after running)
" --tag-relative (maintin full paths in tag file)
" --PHP-Kinds (+cf - Enable Class and Functions -v no variables)
"
" Done twice.  The first one is for your include.  Make sure to set correct path
" Second is for current project.  hitting f4 will reset the tags to newest too
nmap <silent> <F2>
            \ :!ctags -f ~/.vimtags/incTags
            \ -h ".php.inc.class" -R
            \ --totals=yes
            \ --exclude=*.svn
            \ --exclude=*.git
            \ --exclude=*.js
            \ --exclude=*.gitignore
            \ --exclude=*.css
            \ --langmap="php:+.inc.class"
            \ --sort=yes
            \ --regex-PHP="/abstract class ([^ ]*)/\1/c/"
            \ --regex-PHP="/interface ([^ ]*)/\1/c/"
            \ --tag-relative=yes
            \ --PHP-kinds=+cf ~/include<CR>
nmap <silent> <F3>
            \ :!ctags -f ~/.vimtags/housing
            \ -h ".php.inc.class" -R
            \ --totals=yes
            \ --exclude=*.svn
            \ --exclude=*.git
            \ --exclude=*.js
            \ --exclude=*.gitignore
            \ --exclude=*.css
            \ --langmap="php:+.inc.class"
            \ --sort=yes
            \ --regex-PHP='/abstract class ([^ ]*)/\1/c/'
            \ --regex-PHP='/interface ([^ ]*)/\1/c/'
            \ --tag-relative=yes
            \ --PHP-kinds=+cf ~/housing<CR>

nmap <silent> <C-i>
            \ :%s/\(['"a-zA-Z]\)=>\(['"a-zA-Z0-9$]\)/\1 => \2/g<CR>
nmap <silent> <C-o>
            \ :s/\(['"a-zA-Z]\)=>\(['"a-zA-Z0-9$]\)/\1 => \2/g<CR>

set tags=~/.vimtags/incTags,~/.vimtags/housing


filetype plugin indent on
set tabstop=4
set shiftwidth=4
"set expandtab


if &diff
    syntax off
    set nohlsearch
    set t_Co=0
endif

if &diff
    " diff mode
    set diffopt+=iwhite
endif

" set foldmethod=indent
" set foldlevel=1
" set foldclose=all
