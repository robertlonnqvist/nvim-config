call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'haishanh/night-owl.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'easymotion/vim-easymotion'

call plug#end()

set clipboard+=unnamedplus

let g:lightline = {
      \   'colorscheme': 'nightowl',
      \   'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \   },
      \ 'component_function': {
      \     'gitbranch': 'fugitive#head'
      \   },
      \ }

" if hidden is not set, TextEdit might fail.
set hidden
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

set noshowmode " displayed by the lightline plugin
set number relativenumber 
set cursorline
set title

" having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

let mapleader = ' '

" tab settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab " use white spaces instead of tabs
set colorcolumn=120

set termguicolors
colorscheme night-owl

set spelllang=en_us

" spell-check Markdown files and Git Commit Messages
autocmd FileType markdown setlocal spell complete+=kspell
autocmd FileType gitcommit setlocal spell complete+=kspell

set splitbelow splitright

nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize +2<CR>
nnoremap <C-Right> :vertical resize -2<CR>
