scriptencoding utf-8

set nocompatible
set number
set relativenumber
set numberwidth=4
" show diagnostic signs in numbers column - for gitsigns
"set signcolumn=number

"####### Indents #######
set autoindent
"set smartindent
"set cindent

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
" open splits intuitively
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





let mapleader=","

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

    " LSP
    " steps: install lsp, install language server, configure lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'jose-elias-alvarez/null-ls.nvim'
    " Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
    Plug 'simrat39/symbols-outline.nvim'
    Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
    " Plug 'williamboman/mason.nvim'
    " Plug 'williamboman/mason-lspconfig.nvim'

    " lsp autocomplete
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'onsails/lspkind-nvim'
    
    " lsp autocomplete snippets
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'rafamadriz/friendly-snippets'

    " treesitter
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

    "comment
    Plug 'numToStr/Comment.nvim'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'
    " Plug 'tpope/vim-rhubarb'
    Plug 'lewis6991/gitsigns.nvim'

    " rust-analyzer
    " Plug 'simrat39/rust-tools.nvim'

    " flutter-tools
    Plug 'akinsho/flutter-tools.nvim'

    " Debugging
    Plug 'mfussenegger/nvim-dap'
    Plug 'leoluz/nvim-dap-go'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'theHamsta/nvim-dap-virtual-text'
    Plug 'nvim-telescope/telescope-dap.nvim'

    " Plug 'tpope/vim-dispatch'
    " Plug 'sbdchd/neoformat'

    Plug 'tpope/vim-obsession'

    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
    Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}


    call plug#end()
    syntax enable
    " set background=dark
    if (has("termguicolors"))
        set termguicolors     " enable true colors support
    endif
    colorscheme dracula
    lua require('exsqzme')
endif


" Load filetype-specific indent files
" Also enables plugins?
filetype plugin indent on





" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" disable auto highlighting of Matched Parentheses?
let loaded_matchparen = 1






" set above plug so lua files can have access (good ?)
" let mapleader=","

" Prevent entering EX mode ? vi compat?
nnoremap <silent> Q <nop>
nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<CR>
" TODO
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
" nnoremap <leader>h :wincmd h<Cr>
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


" https://github.com/nvim-telescope/telescope.nvim/issues/592
" airblade/vim-rooter
" https://github.com/airblade/vim-rooter
nnoremap <c-p> :Telescope find_files <cr>
" nnoremap <c-p> :Telescope find_files cwd=%:p:h <cr>
" telescope bufers
" telescope live_grep


nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

"Get keycode
"https://vi.stackexchange.com/questions/26611/is-it-possible-to-map-control-forward-slash-with-vim



" Ctrl+/
" nnoremap <C-_> :Telescope current_buffer_fuzzy_find sorting_strategy=ascending prompt_position=top <cr>
"nnoremap <C-_> <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({ sorting_strategy="ascending", layout_config={ prompt_position="top" } })<cr>
nnoremap <C-/> <cmd>lua require('exsqzme.telescope.utils').curbuf() <cr>
nnoremap <F4> :lua package.loaded.exsqzme = nil <cr>
"nnoremap <C-k> :cnext<CR>
"nnoremap <C-j> :cprev<CR>

nnoremap <leader>en <cmd>lua require('exsqzme.telescope.utils').edit_neovim() <cr>
nnoremap <leader>ez <cmd>lua require('exsqzme.telescope.utils').edit_zsh() <cr>



" where M = alt
" enable alt on mac via terminal settings
" kitty maos_option_as_alt left
"
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
