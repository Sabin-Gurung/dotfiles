vim.cmd [[
set guioptions=
set clipboard=unnamed
set noshowmode
set listchars=eol:¬,tab:>-,trail:.,extends:>,precedes:<
set shortmess+=c
set hidden
set hlsearch incsearch
set autoindent copyindent smartindent
highlight WinSeparator guifg=NONE
set nu
set encoding=utf-8
set nowrap
set splitright splitbelow
set laststatus=2
set signcolumn=number
set noswapfile nobackup nowritebackup
set pumheight=8
set scrolloff=5
set noerrorbells
set shiftwidth=4 softtabstop=4 expandtab smartindent
set laststatus=3
highlight WinSeparator guifg=NONE
autocmd BufWritePre * :%s/\s\+$//e
nohl
syntax on
let mapleader = " "
let maplocalleader = ","
imap jk <Esc>
tnoremap jk <c-\><c-n>
nnoremap Q @q
nnoremap Y y$
nnoremap <silent> <C-]> :e #<CR>
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>
nnoremap [q :cprev <CR>
nnoremap ]q :cnext <CR>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-j> jzz
nnoremap <C-k> kzz
nnoremap <leader>oq :copen <CR>
nnoremap <leader>sr :%s//
xnoremap <leader>sr :s//
nnoremap <leader>sn :nohl<CR>
nnoremap <leader>wv :wincmd v<CR>
nnoremap <leader>ws :wincmd s<CR>
nnoremap <leader>wo :wincmd o<CR>
nnoremap <leader>wq :wincmd q<CR>
nnoremap <leader>w<Left> :vertical resize +7<CR>
nnoremap <leader>w<Right> :vertical resize -7<CR>
nnoremap <leader>w<Up> :resize +7<CR>
nnoremap <leader>w<Down> :resize -7<CR>
nnoremap <leader>qq :qall<CR>
nnoremap <leader>qQ :qall!<CR>
nnoremap <leader>bD :bufdo bd<CR>
nnoremap <leader>bd :bd!<CR>
nnoremap <leader>' :12sp term://zsh<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

command! -range=% IndentJson :<line1>,<line2>!python3 -m json.tool
]]

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = '*',
})

-- ====== packages ==============
require("core.lazy")

