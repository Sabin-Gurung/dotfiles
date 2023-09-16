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
" autocmd BufWritePre * :%s/\s\+$//e
nohl
syntax on
let mapleader = " "
let maplocalleader = ","
imap jk <Esc>
tnoremap jk <c-\><c-n>
nnoremap Q @q
nnoremap Y y$
nnoremap <silent> <C-]> :e #<CR>
nnoremap <leader>wh :wincmd h<CR>
nnoremap <leader>wj :wincmd j<CR>
nnoremap <leader>wk :wincmd k<CR>
nnoremap <leader>wl :wincmd l<CR>
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
nnoremap <leader>ww :wincmd w<CR>
nnoremap <leader>wv :wincmd v<CR>
nnoremap <leader>ws :wincmd s<CR>
nnoremap <leader>wo :wincmd o<CR>
nnoremap <leader>wq :wincmd q<CR>
nnoremap <leader>qq :qall<CR>
nnoremap <leader>qQ :qall!<CR>
nnoremap <leader>bD :bufdo bd<CR>
nnoremap <leader>bd :bd!<CR>
nnoremap <leader>' :12sp term://zsh<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

command! VimSource execute "source ~/.config/nvim/init.lua"
command! VimConfig execute "e ~/.config/nvim/init.lua"
command! -range=% IndentJson :<line1>,<line2>!python3 -m json.tool
nnoremap <leader>vrc :VimConfig<CR>
nnoremap <leader>vrs :VimSource<CR>
]]

-- ====== package manager ==============
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'
    use 'tpope/vim-fugitive'
    use 'mbbill/undotree'
    use { 'morhetz/gruvbox', config = 'vim.cmd[[colorscheme gruvbox]]' }
    use 'jiangmiao/auto-pairs'
    use 'nvim-lualine/lualine.nvim'
    use 'mhinz/vim-startify'
    use 'scrooloose/nerdtree'
    use { "AckslD/nvim-neoclip.lua", config = function() require('neoclip').setup{ default_register = '*', on_select = { move_to_front = true}} end }
    use { 'Olical/conjure' , ft = 'clojure'}
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
    use {
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'folke/neodev.nvim',
    }
    use {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
    }

    if packer_bootstrap then require('packer').sync() end
end)
-- --======================================
