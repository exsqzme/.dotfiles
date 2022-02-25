set scrolloff=8
set number
set relativenumber
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smartindent

" Install vim-plug if not already installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
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
    call plug#end()
endif

if (has("termguicolors"))
    set termguicolors     " enable true colors support
endif
syntax enable
" set background=dark
colorscheme dracula

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
" nnoremap <C-p> :GFiles<CR>
" nnoremap <leader>pf :Files<CR>
nnoremap <C-k> :cnext<CR>
nnoremap <C-j> :cprev<CR>

" delete in visual mode without overriting previous paste; then paste the
" previous paste
vnoremap <leader>p "_dP
" yank into system clipboard (ctrl v)
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

set re=0
"Telescope fzf
lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
    defaults = {
        --mappings = {
          --  n = {
           --     ['<C-j'] = action.move_selection_previous
           -- }
       -- }
    }
}
require('telescope').load_extension('fzf')
EOF
