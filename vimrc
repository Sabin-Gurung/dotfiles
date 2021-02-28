set guioptions=
set noshowmode
set listchars=eol:¬,tab:>-,trail:.,extends:>,precedes:<
set shortmess+=c
set nolist
set hidden
set hlsearch incsearch
set autoindent copyindent smartindent
set nu 
" set relativenumber
" set signcolumn=yes
set nowrap
set laststatus=2
set noswapfile nobackup nowritebackup
set pumheight=10
set scrolloff=7
set noerrorbells
set shiftwidth=4 softtabstop=4 expandtab smartindent
syntax on

command! VimConfig execute "e ~/.vimrc"
command! VimSource execute "source ~/.vimrc"

let mapleader = " "
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

command! IndentJson %!python -m json.tool

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
call plug#end()
filetype plugin indent on

colorscheme gruvbox
set background=dark

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
