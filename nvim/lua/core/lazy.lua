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
    { 'morhetz/gruvbox', config = function () vim.cmd[[colorscheme gruvbox]] end },
    { "AckslD/nvim-neoclip.lua", config = function() require('neoclip').setup{ default_register = '*', on_select = { move_to_front = true}} end },
    { 'Olical/conjure' , ft = 'clojure' },
    {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            "nvim-telescope/telescope-file-browser.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
        }
    },
    {
        'ThePrimeagen/harpoon',
        config = function ()
            local harpoon_mark = require("harpoon.mark")
            local harpoon_ui = require("harpoon.ui")
            local harpoon_term = require("harpoon.term")
            vim.keymap.set('n', '<leader>ha', function () harpoon_mark.add_file() end, {desc = 'Harpoon add'})
            vim.keymap.set('n', '<leader>ho', function () harpoon_ui.toggle_quick_menu() end, {desc = 'Harpoon list'})
            vim.keymap.set('n', '<leader>ht', function () harpoon_term.gotoTerminal(1) end, {desc = 'Harpoon terminal'})
        end
    },
    {
        'scrooloose/nerdtree',
        config = function ()
            local function nerd_tree_toggle()
                vim.cmd[[NERDTreeToggle
                silent NERDTreeMirror]]
            end
            vim.keymap.set('n', '<leader>ft', nerd_tree_toggle, {desc = "nerd_tree_toggle"})
            vim.cmd [[ nnoremap <leader>fl :NERDTreeFind<CR> ]]
            vim.g.NERDTreeMinimalUI=1
            vim.g.NERDTreeWinSize=40
        end
    },
})

