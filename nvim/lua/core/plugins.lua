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
        enabled = false,
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
    {
        'ms-jpq/chadtree',
        keys = {
            { "<leader>ft", "<cmd>CHADopen<cr>", desc = "CHAD Tree" },
        },
        config = function ()
            local chadtree_settings = { theme = { icon_glyph_set = "ascii", text_colour_set = "nord" } }
            vim.api.nvim_set_var("chadtree_settings", chadtree_settings)
            -- vim.cmd [[ nnoremap <leader>ft :CHADopen<CR> ]]
        end
    },
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
    { 'ThePrimeagen/harpoon' },
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

