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
    { 'windwp/nvim-autopairs', event = "InsertEnter", config = true, enabled = true },
    'mhinz/vim-startify',
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'folke/neodev.nvim',
        }
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
        }
    },
    {
        'mbbill/undotree',
        keys = { { "<leader>ou", "<cmd>UndotreeToggle<cr>", desc = "Undotree" } },
        config = function () vim.g.undotree_SetFocusWhenToggle=1 end
    },
    { 'morhetz/gruvbox', lazy = false, priority = 1000, config = function () vim.cmd[[colorscheme gruvbox]] end },
    { "AckslD/nvim-neoclip.lua", config = function() require('neoclip').setup{ default_register = '*', on_select = { move_to_front = true}} end },
    { 'Olical/conjure' , ft = 'clojure' },
    {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            "nvim-telescope/telescope-file-browser.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = function() return vim.fn.executable 'make' == 1 end },
        }
    },
    {
        'ThePrimeagen/harpoon',
        config = function ()
            local harpoon_mark = require("harpoon.mark")
            local harpoon_ui = require("harpoon.ui")
            vim.keymap.set('n', '<leader>ha', function () harpoon_mark.add_file() end, {desc = 'Harpoon add'})
            vim.keymap.set('n', '<leader>ho', function () harpoon_ui.toggle_quick_menu() end, {desc = 'Harpoon list'})
        end
    },
    {
        'scrooloose/nerdtree',
        keys = {
            { "<leader>fl", "<cmd>NERDTreeFind<cr>", desc = "NERDTree find" },
            { "<leader>ft", "<cmd>NERDTreeToggle<cr>", desc = "NERDTree toggle" }
        },
        config = function ()
            -- local function nerd_tree_toggle()
            --     vim.cmd[[NERDTreeToggle
            --     silent NERDTreeMirror]]
            -- end
            vim.g.NERDTreeMinimalUI=1
            vim.g.NERDTreeWinSize=40
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
                component_separators = '|',
                section_separators = '',
            },
        }
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        cmd = "Oil",
    }
})

