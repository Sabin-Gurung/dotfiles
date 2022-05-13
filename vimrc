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
set splitright
set laststatus=2
set signcolumn=number
set noswapfile nobackup nowritebackup
set pumheight=8
set scrolloff=5
set noerrorbells
set shiftwidth=4 softtabstop=4 expandtab smartindent
syntax on

command! VimSource execute "source ~/.vimrc"
command! VimConfig execute "e ~/.vimrc"
command! -range=% IndentJson :<line1>,<line2>!python -m json.tool
command! Todo belowright split ~/tools/todo/todo.todo <bar> :resize 10 <cr>

let mapleader = " "
let maplocalleader = ","
imap jk <Esc>
nnoremap Q @q
nnoremap Y y$
nnoremap <silent> <C-]> :e #<CR>
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>
nnoremap [q :cprev <CR>
nnoremap ]q :cnext <CR>
nnoremap <leader>oq :copen <CR>
nnoremap <leader>sr :%s//
xnoremap <leader>sr :s//
nnoremap <leader>sn :nohl<CR>
nnoremap <leader>vrc :VimConfig<CR>
nnoremap <leader>vrs :VimSource<CR>
nnoremap <leader>ww :wincmd w<CR>
nnoremap <leader>wv :wincmd v<CR>
nnoremap <leader>ws :wincmd s<CR>
nnoremap <leader>wo :wincmd o<CR>
nnoremap <leader>wq :wincmd q<CR>
nnoremap <leader>qq :qall<CR>
nnoremap <leader>qQ :qall!<CR>
nnoremap <leader>bD :bufdo bd<CR>
nnoremap <leader>bd :bd<CR>

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
Plug 'haishanh/night-owl.vim'
Plug 'godlygeek/tabular'
Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" if has("nvim")
"     Plug 'Olical/conjure', {'tag': 'v4.15.0', 'for':'clojure'}
" endif
call plug#end()
filetype plugin indent on

colorscheme gruvbox
highlight Normal     ctermbg=NONE guibg=NONE
" highlight LineNr     ctermbg=NONE guibg=NONE
" highlight SignColumn ctermbg=NONE guibg=NONE

" FZF.vim
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:highlightedyank_highlight_duration = 200
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

" FZF.Mappings
nnoremap <leader><space> :Commands<CR>
nnoremap <C-p> :Files!<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>fC :Colors<CR>
nnoremap <leader>fM :Maps<CR>
nnoremap <leader>fT :Filetypes<CR>
nnoremap <leader>fo :History<CR>
nnoremap <leader>fh :Helptags<CR>
nnoremap <leader>fr :History:<CR>
nnoremap <leader>fs :Rg! 
nnoremap <silent> <leader>f* :Rg! <C-R><C-W><CR>
nnoremap <leader>ft :call ToggleNERDTree()<CR>
nnoremap <leader>fl :NERDTreeFind<CR>

nnoremap <leader>gs :Git<CR>

function! SetPythonCommands()
    nnoremap <buffer> <localleader>ef :e term://python3 %<CR>
endfunction
augroup MY_AU_GROUP 
    autocmd!
    autocmd filetype python call SetPythonCommands()
augroup END 

" conquerer of completion
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ CheckBackspace() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" function! CheckBackspace() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" let g:coc_snippet_next = '<tab>'

nnoremap <silent> <localleader>K :call ShowDocumentation()<CR>
nmap <silent> <localleader>gd <Plug>(coc-definition)
nmap <silent> <localleader>gr <Plug>(coc-references)
nmap <silent> <localleader>gy <Plug>(coc-type-definition)
nmap <silent> <localleader>gi <Plug>(coc-implementation)
nmap <localleader>rn <Plug>(coc-rename)
nmap <localleader>ac  <Plug>(coc-codeaction-cursor)
nmap <localleader>qf  <Plug>(coc-fix-current)
nmap <localleader>cl  <Plug>(coc-codelens-action)

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

