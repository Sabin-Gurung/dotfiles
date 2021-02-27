set noshowmode
set listchars=eol:¬,tab:>-,trail:.,extends:>,precedes:<
set nolist
set hidden
set hlsearch incsearch
set autoindent copyindent smartindent
set nu relativenumber
set nowrap
set laststatus=2
set noswapfile nobackup nowritebackup
set pumheight=10
" set completeopt=menuone,longest
set scrolloff=7
set noerrorbells
set shiftwidth=4 softtabstop=4 expandtab smartindent
syntax on

command! VimConfig execute "e ~/.vimrc"
command! VimSource execute "source ~/.vimrc"

let mapleader = " "
imap jk <Esc>
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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
filetype plugin indent on

colorscheme gruvbox
set background=dark

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified'],
      \             ['cocstatus', 'currentfunction'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

function! GoFilesFZF()
    if '' == fugitive#statusline()
        GFiles!
    else
        Files!
    endif
endfunction

function! ToggleNERDTree()
    NERDTreeToggle
    silent NERDTreeMirror
endfunction

nnoremap <leader><space> :Commands<CR>
nnoremap <C-p> :call GoFilesFZF()<CR>
nnoremap ¡ :call ToggleNERDTree()<CR>
nnoremap <leader>bb :Buffers<CR>
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gu <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)


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
