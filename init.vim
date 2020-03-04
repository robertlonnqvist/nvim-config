call plug#begin()

" javascript
Plug 'othree/yajs.vim'

" typescript
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'

Plug 'mhartington/oceanic-next'

call plug#end()

if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else         " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

" NetRw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" tab settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab     " use white spaces instead of tabs

let g:airline_theme='oceanicnext'

set termguicolors
set background=dark
colorscheme OceanicNext
