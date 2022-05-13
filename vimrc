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

command! -range=% IndentJson :<line1>,<line2>!python -m json.tool
command! Todo belowright split ~/tools/todo/todo.todo <bar> :resize 10 <cr>

call plug#begin('~/.vim/plugged')
" Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'machakann/vim-highlightedyank'
Plug 'mbbill/undotree'
Plug 'godlygeek/tabular'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-startify'

Plug 'haishanh/night-owl.vim'
Plug 'morhetz/gruvbox'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'Olical/conjure', {'tag': 'v4.15.0', 'for':'clojure'}
call plug#end()
filetype plugin indent on


colorscheme gruvbox
highlight Normal     ctermbg=NONE guibg=NONE
" highlight LineNr     ctermbg=NONE guibg=NONE
" highlight SignColumn ctermbg=NONE guibg=NONE


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
nnoremap <leader>ft :call ToggleNERDTree()<CR>
nnoremap <leader>fl :NERDTreeFind<CR>
nnoremap <leader>ou :UndotreeToggle<CR>


lua << EOF
require('telescope').load_extension('fzf')
EOF
" Telescope
nnoremap <leader><space> <cmd>Telescope commands<cr>
nnoremap <c-p> <cmd>Telescope find_files<cr>
" nnoremap <c-p> <cmd>Telescope git_files<cr>
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>fC <cmd>Telescope colorscheme<cr>
nnoremap <leader>fj <cmd>Telescope jumplist<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>
nnoremap <leader>fM <cmd>Telescope keymaps<cr>
nnoremap <leader>fT <cmd>Telescope filetypes<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope command_history<cr>
nnoremap <leader>fs <cmd>Telescope live_grep<cr>
nnoremap <leader>f/ <cmd>Telescope search_history<cr>
nnoremap <silent> <leader>f* <cmd>Telescope grep_string<cr>
nnoremap <leader>fz <cmd>Telescope spell_suggest<cr>

nnoremap <leader>gs :Git<CR>
nnoremap <leader>ga :Git blame<CR>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>gh <cmd>Telescope git_bcommits<cr>

function! SetPythonCommands()
    nnoremap <buffer> <localleader>ef :e term://python3 %<CR>
endfunction
augroup MY_AU_GROUP 
    autocmd!
    autocmd filetype python call SetPythonCommands()
augroup END 

nnoremap <silent> <localleader>K :call ShowDocumentation()<CR>
nmap <silent> <localleader>gd <Plug>(coc-definition)
nmap <silent> <localleader>gr <Plug>(coc-references)
nmap <silent> <localleader>gy <Plug>(coc-type-definition)
nmap <silent> <localleader>gi <Plug>(coc-implementation)
nmap <localleader>rr <Plug>(coc-rename)
nmap <localleader>ac <Plug>(coc-codeaction-cursor)
nmap <localleader>qf <Plug>(coc-fix-current)
nmap <localleader>cl <Plug>(coc-codelens-action)
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

