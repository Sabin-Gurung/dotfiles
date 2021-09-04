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
set nowrap
set laststatus=2
set noswapfile nobackup nowritebackup
set pumheight=8
set scrolloff=5
set noerrorbells
set shiftwidth=4 softtabstop=4 expandtab smartindent
syntax on


command! VimSource execute "source ~/.vimrc"
command! VimConfig execute "e ~/.vimrc"

let mapleader = " "
let maplocalleader = ","
imap jk <Esc>
nnoremap Q @q
nnoremap Y y$
nnoremap <silent> <C-]> :e #<CR>
nnoremap <leader>wv :wincmd v<CR>
nnoremap <leader>ww :wincmd w<CR>
nnoremap <leader>ws :wincmd s<CR>
nnoremap <leader>wo :wincmd o<CR>
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>
nnoremap <leader>sr :%s//
xnoremap <leader>sr :s//
nnoremap <leader>sn :nohl<CR>
nnoremap [q :cprev <CR>
nnoremap ]q :cnext <CR>

command! -range=% IndentJson :<line1>,<line2>!python -m json.tool
command! Todo belowright split ~/tools/todo/todo.todo <bar> :resize 10 <cr>

set splitright

" ------------------------ plug in settings ---------------------------
call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'itchyny/lightline.vim'
Plug 'mbbill/undotree'
Plug 'machakann/vim-highlightedyank'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'haishanh/night-owl.vim'

if has("nvim")
    Plug 'Olical/conjure', {'tag': 'v4.15.0', 'for':'clojure'}
endif

call plug#end()
filetype plugin indent on

colorscheme night-owl
" highlight Normal     ctermbg=NONE guibg=NONE
" highlight LineNr     ctermbg=NONE guibg=NONE
" highlight SignColumn ctermbg=NONE guibg=NONE

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

let NERDTreeMinimalUI=1
let NERDTreeWinSize=40
function! ToggleNERDTree()
    NERDTreeToggle
    silent NERDTreeMirror
endfunction

let g:startify_files_number = 7

let g:highlightedyank_highlight_duration = 200

nnoremap <leader><space> :Commands<CR>
nnoremap <C-p> :Files!<CR>
nnoremap <leader>ft :call ToggleNERDTree()<CR>
nnoremap <leader>fl :NERDTreeFind<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>bD :bufdo bd<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>gs :Git<CR>

function! SetPythonCommands()
    nnoremap <buffer> <localleader>ef :e term://python3 %<CR>
endfunction

augroup MY_AU_GROUP 
    autocmd!
    autocmd filetype python call SetPythonCommands()
augroup END 
