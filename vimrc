set noshowmode
set listchars=eol:¬,tab:>-,trail:.,extends:>,precedes:<
set nolist
set hidden
set hlsearch incsearch
set autoindent copyindent smartindent
set nu relativenumber
set nowrap
set laststatus=2
set noswapfile backup
set scrolloff=7
set noerrorbells
set shiftwidth=4 softtabstop=4 expandtab smartindent

let mapleader = " "
imap jk <Esc>
command! VimConfig execute "e ~/.vimrc"
command! VimSource execute "source ~/.vimrc"

nnoremap <C-]> :e #<CR>
nnoremap <leader>wv :wincmd v<CR>
nnoremap <leader>ws :wincmd s<CR>
nnoremap <leader>wo :wincmd o<CR>
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

command! IndentJson %!python -m json.tool

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Declare the list of plugins.
Plug 'scrooloose/nerdtree'
Plug 'Townk/vim-autoclose'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
call plug#end()
filetype plugin indent on

colorscheme gruvbox
set background=dark

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

no <leader><space> :Commands<CR>
nnoremap <C-p> :Files!<CR>
nnoremap <leader>bb :Buffers<CR>

" Unmap the arrow keys
no <down> <Nop>
no <right> <Nop>
no <left> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <right> <Nop>
ino <left> <Nop>
ino <up> <Nop>
vno <left> <Nop>
vno <up> <Nop>
