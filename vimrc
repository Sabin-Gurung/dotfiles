" ------------------------ non plug in settings ---------------------------
set guioptions=
set clipboard=unnamed
set noshowmode
set listchars=eol:¬,tab:>-,trail:.,extends:>,precedes:<
set shortmess+=c
set hidden
set hlsearch incsearch
set autoindent copyindent smartindent
set nu 
" set relativenumber
" set signcolumn=yes
set nowrap
set laststatus=2
set noswapfile nobackup nowritebackup
set pumheight=8
set scrolloff=7
set noerrorbells
set shiftwidth=4 softtabstop=4 expandtab smartindent
syntax on

command! VimConfig execute "e ~/.vimrc"
command! VimSource execute "source ~/.vimrc"

let mapleader = " "
let maplocalleader = ","
imap jk <Esc>
nnoremap Y y$
nnoremap <silent> <C-]> :e #<CR>
nnoremap <leader>wv :wincmd v<CR>
nnoremap <leader>ws :wincmd s<CR>
nnoremap <leader>wo :wincmd o<CR>
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>
no <down> <Nop>
no <right> <Nop>
no <left> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <right> <Nop>
ino <left> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <right> <Nop>
vno <left> <Nop>
vno <up> <Nop>

command! IndentJson %!python -m json.tool

" ------------------------ plug in settings ---------------------------
call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'Townk/vim-autoclose'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'mbbill/undotree'
if has("nvim")
    Plug 'Olical/conjure', {'tag': 'v4.15.0'}
    Plug 'guns/vim-sexp'
    Plug 'tpope/vim-sexp-mappings-for-regular-people'
endif
call plug#end()
filetype plugin indent on

colorscheme gruvbox
set background=dark

let g:undotree_SetFocusWhenToggle=1

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ }

function! ToggleNERDTree()
    NERDTreeToggle
    silent NERDTreeMirror
endfunction

nnoremap <leader><space> :Commands<CR>
nnoremap <C-p> :Files!<CR>
nnoremap <leader>of :call ToggleNERDTree()<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>gs :Git<CR>
