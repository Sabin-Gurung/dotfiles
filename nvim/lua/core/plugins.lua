local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'tpope/vim-surround',
    'tpope/vim-commentary',
    'tpope/vim-repeat',
    'tpope/vim-fugitive',
    'mbbill/undotree',
    'jiangmiao/auto-pairs',
    'nvim-lualine/lualine.nvim',
    'mhinz/vim-startify',
    'scrooloose/nerdtree',
    {
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'folke/neodev.nvim',
    },
    {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
        'L3MON4D3/LuaSnip',
    },
    {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            "nvim-telescope/telescope-file-browser.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 },
        }
    },
    { 'morhetz/gruvbox', config = function () vim.cmd[[colorscheme gruvbox]] end },
    { "AckslD/nvim-neoclip.lua", config = function() require('neoclip').setup{ default_register = '*', on_select = { move_to_front = true}} end },
    { 'Olical/conjure' , ft = 'clojure' },
})

