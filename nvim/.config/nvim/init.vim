set nocompatible
set number
set relativenumber

"####### Indents #######
set autoindent
"set smartindent
"set cindent
"
" Load filetype-specific indent files
" Also enables plugins?
filetype plugin indent on

"##### tabs #####
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set nojoinspaces

"####### Buffers ########
set hidden " I like having buffers stay around




"####### screen ######
" enough for line numbers + gutter within 80 standard
" Vim won't do anything unless requested. textwidth will have an effect for currently edited lines if you either have t (for non-comments only), c (for comments only) or both in formatoptions (if a is not present there, then it will autowrap only when you reach the margin set by textwidth), or if you use gq to reformat your text. If I am not mistaking, you can set such formatexpr or formatprg so that textwidth will be ignored.
" Try gggqGto apply the new text width to the whole buffer.
set textwidth=72
set colorcolumn=80
set wrap
set breakindent
set linebreak
let &showbreak=repeat(' ', 3)

"###### FORMATTING OPTIONS ############
set fo-=t   " don't auto-wrap text using text width
set fo+=c   " autowrap comments using textwidth with leader
set fo+=r   " auto-insert comment leader on enter in insert
set fo-=o   " don't auto-insert comment leader on o/O in normal
set fo+=q   " allow formatting of comments with gq
set fo-=w   " don't use trailing whitespace for paragraphs
set fo-=a   " disable auto-formatting of paragraph changes
set fo-=n   " don't recognized numbered lists
set fo+=j   " delete comment prefix when joining
set fo-=2   " don't use the indent of second paragraph line
set fo-=v   " don't use broken 'vi-compatible auto-wrapping'
set fo-=b   " don't use broken 'vi-compatible auto-wrapping'
set fo+=l   " long lines not broken in insert mode
set fo+=m   " multi-byte character line break support
set fo+=M   " don't add space before or after multi-byte char
set fo-=B   " don't add space between two multi-byte chars
set fo+=1   " don't break a line after a one-letter word






"####### screen PART 2 ######
set scrolloff=8
set icon
"set showmatch
set showcmd
set cmdheight=1 " Give more space for displaying messages.
" set noequalalways
" set splitright
" set splitbelow
set ttyfast " faster scrolling
set title
set showmode
set ruler " show cursor position
set nostartofline " dont reest cursor to start of line when moving around
set laststatus=2 " always show status line






set mouse=a
set cursorline
"set guicursor=





"##### Sys ####
set noswapfile
set nobackup
set updatetime=100
set t_vb= " disable visual bell (also disable in .inputrc)
"set noerrorbells
set belloff=all
set undodir=~/.vim/undodir
set undofile
set clipboard=unnamedplus " use y and p with the system clipboard
" set viminfo=!,'100,<1000,s1000,h " vimrc
set shada=!,'100,<1000,s1000,h "neovim
    " ! save and restore global variables (ALL CAPS)
    " '100 remember marks in up to 100 files (the default value)
    " <1000 remember registers with up to 1000 lines
    " s1000 remember registers with content weighting up to 1000 kb
    " h doesnt apply highlighting on load
"set shortmess=aoOtTI " avoid most of the 'Hit Enter ...' messages
set shortmess=atI " dont show intro msg when starting
set nofixendofline
"set path+=** " https://www.reddit.com/r/vim/comments/8mi8cm/is_using_in_path_a_good_idea/
set history=100 " default is 10000 - change if needed, not sure why yet
set re=0









" Cool floating window popup menu for completion on command line
set pumblend=17
set wildmode=longest:full
set wildoptions=pum

"t Nice menu when typing `:find *.py`
"set wildmode=longest,list,full
"set wildmenu


set wildignore=*.o,*~,*.pyc " Ignore compiled files


            
"###### Search #######
set nohlsearch
set incsearch
set wrapscan
set ignorecase " Ignore case when searching...
set smartcase " ... unless there is a capital letter in the query
set gdefault " Add the g flag to search/replace by default


















" requires PLATFORM env variable set (in ~/.bashrc)
if $OS == 'Mac'
  " required for mac delete to work
  set backspace=indent,eol,start
endif





" only load plugins if Plug detected
if filereadable(expand("~/.local/share/nvim/site/autoload/plug.vim"))
    call plug#begin('~/.config/nvim/plugged')
    "FZF
    "  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    "  Plug 'junegunn/fzf.vim'

    "Dracula
    Plug 'dracula/vim', { 'as': 'dracula' }

    "Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    call plug#end()
    syntax enable
    " set background=dark
    colorscheme dracula
    lua require('exsqzme.telescope')
endif

if (has("termguicolors"))
    set termguicolors     " enable true colors support
endif







" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" disable auto highlighting of Matched Parentheses?
let loaded_matchparen = 1






let mapleader=","

" Prevent entering EX mode ? vi compat?
nnoremap <silent> Q <nop>
" TODO
nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<CR>
"inoremap <Up>     <C-o>:echom "--> k <-- "<CR>
"inoremap <Down>   <C-o>:echom "--> j <-- "<CR>
"inoremap <Right>  <C-o>:echom "--> l <-- "<CR>
"inoremap <Left>   <C-o>:echom "--> h <-- "<CR>

" scroll vertical
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>
" Switch between tabs
nnoremap <Right> gt
nnoremap <Left>  gT

" Easier Moving between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Make windows to be basically the same size
nnoremap <leader>= <C-w>=

" Sizing window horizontally
nnoremap <c-,> <C-W><
nnoremap <c-.> <C-W>>
nnoremap <A-,> <C-W>5<
nnoremap <A-.> <C-W>5>

" Sizing window vertically
" taller
nnoremap <A-t> <C-W>+
" shorter
nnoremap <A-s> <C-W>-


" Navigate buffers
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bf :bfirst<CR>
nnoremap <leader>bl :blast<CR>


if has('nvim')
    " Make esc leave terminal mode
    tnoremap <leader><Esc> <C-\><C-n>
    tnoremap <Esc><Esc> <C-\><C-n>

    " Easy moving between the buffers
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l

    " Try and make sure to not mangle space items
    tnoremap <S-Space> <Space>
    tnoremap <C-Space> <Space>
endif


" Helpful delete/change into blackhole buffer
nmap <leader>d "_d
nmap <leader>c "_c
nmap <space>d "_d
nmap <space>c "_c
" why nmap vs nnoremap ?? TODO: recursion? how?
"nnoremap <leader>d "_d
" vnoremap <leader>d "_d






" Opens line below or above the current line
inoremap <S-CR> <C-O>o
inoremap <C-CR> <C-O>O


" Search results mid screen
nnoremap n nzzzv
nnoremap N Nzzzv




" Copy line with no carriage return ?
nnoremap Y yg$
" Join next line with current
nnoremap J mzJ`z

" delete in visual mode without overriting previous paste; then paste the
" previous paste
vnoremap <leader>p "_dP
" yank into system clipboard (ctrl v)
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nmap <leader>Y "+Y
nnoremap <leader>ya gg"+yG





" Change the working directory for everybody
nnoremap <leader>cd :windo lcd 

nnoremap <leader>x :silent !chmod +x %<CR>
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>






"nnoremap <C-k> :cnext<CR>
"nnoremap <C-j> :cprev<CR>





" where M = alt
"inoremap <M-j> <Esc>:m .+1<CR>==gi
"inoremap <M-k> <Esc>:m .-2<CR>==gi
"vnoremap <M-j> :m '>+1<CR>gv=gv
"vnoremap <M-k> :m '<-2<CR>gv=gv
inoremap <Down> <Esc>:m .+1<CR>==gi
inoremap <Up> <Esc>:m .-2<CR>==gi
vnoremap <Down> :m '>+1<CR>gv=gv
vnoremap <Up> :m '<-2<CR>gv=gv
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv





nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>



" https://stackoverflow.com/questions/19430200/how-to-clear-vim-registers-effectively
fun! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfun

" Strip trailing whitespace (,ss)
" alternative = nnoremap <leader>sws :%s/\s\+$//<CR>
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>
