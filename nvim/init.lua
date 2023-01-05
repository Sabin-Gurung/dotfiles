vim.cmd [[
set guioptions=
set clipboard=unnamed
set noshowmode
set listchars=eol:¬,tab:>-,trail:.,extends:>,precedes:<
set shortmess+=c
set hidden
set hlsearch incsearch
set autoindent copyindent smartindent
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
nohl
syntax on
let mapleader = " "
let maplocalleader = ","
imap jk <Esc>
tnoremap jk <c-\><c-n>
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
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv
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
    use 'morhetz/gruvbox'
    use 'jiangmiao/auto-pairs'
    use 'nvim-lualine/lualine.nvim'
    use 'mhinz/vim-startify'
    use 'scrooloose/nerdtree'
    use { 'Olical/conjure' , ft = 'clojure'}
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
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
    }

    if packer_bootstrap then require('packer').sync() end
end)
-- --======================================
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
require('lualine').setup { options = { icons_enabled = false, component_separators = '|', section_separators = '', }, }
vim.g.undotree_SetFocusWhenToggle=1
vim.cmd [[
colorscheme gruvbox
nnoremap <leader>gs :Git<CR>
nnoremap <leader>ga :Git blame<CR>
nnoremap <leader>ou :UndotreeToggle<CR>
let NERDTreeMinimalUI=1
let NERDTreeWinSize=40
function! ToggleNERDTree()
NERDTreeToggle
silent NERDTreeMirror
endfunction
nnoremap <leader>ft :call ToggleNERDTree()<CR>
nnoremap <leader>fl :NERDTreeFind<CR>
]]
-- ======== telescope ===================
local telescope = require('telescope')
local filesOpts = {previewer = false, find_command={"rg", "--ignore", "-L", "--hidden", "--files"}}
telescope.setup{
    defaults = {
        layout_strategy = "vertical",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" }
    },
    pickers = {
        find_files = filesOpts,
        git_files = filesOpts,
        buffers = filesOpts,
    }
}
local tel_actions = require "telescope.actions"
local tel_builtin = require "telescope.builtin"
local tel_action_state = require "telescope.actions.state"
vim.api.nvim_create_user_command("TelescopeProjects", function()
    tel_builtin.find_files({find_command={"fd", ".git$", "-t", "d", "-H", "/Users/sabingurung/workspace", "|", "echo", "hello"},
    prompt_prefix = "Projects > ",
    attach_mappings = function (prompt_buffer, _)
        tel_actions.select_default:replace(function()
            local text = tel_action_state.get_selected_entry()[1]:gsub(".git", "")
            tel_actions.close(prompt_buffer)
            vim.cmd("cd " .. text)
            tel_builtin.git_files()
        end)
        return true
    end})
end, {})
vim.api.nvim_create_user_command("TelescopePFiles", function() if not pcall(tel_builtin.git_files, {}) then tel_builtin.find_files() end end, {})
pcall(require('telescope').load_extension, 'fzf')
vim.keymap.set('n', '<leader><space>', tel_builtin.commands, {})
vim.keymap.set('n', '<c-p>', '<cmd>TelescopePFiles<cr>')
vim.keymap.set('n', '<leader>bb', tel_builtin.buffers, {})
vim.keymap.set('n', '<leader>fC', tel_builtin.colorscheme, {})
vim.keymap.set('n', '<leader>fj', tel_builtin.jumplist, {})
vim.keymap.set('n', '<leader>fm', tel_builtin.marks, {})
vim.keymap.set('n', '<leader>fM', tel_builtin.keymaps, {})
vim.keymap.set('n', '<leader>fT', tel_builtin.filetypes, {})
vim.keymap.set('n', '<leader>fo', tel_builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fh', tel_builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', tel_builtin.command_history, {})
vim.keymap.set('n', '<leader>fs', tel_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fS', ':Telescope grep_string search=', {})
vim.keymap.set('n', '<leader>f/', tel_builtin.search_history, {})
vim.keymap.set('n', '<leader>f*', tel_builtin.grep_string, {})
vim.keymap.set('n', '<leader>fz', tel_builtin.spell_suggest, {})
vim.keymap.set('n', '<leader>gb', tel_builtin.git_branches, { desc = "remap" })
vim.keymap.set('n', '<leader>gh', tel_builtin.git_bcommits, {})
vim.cmd [[
augroup MY_AU_GROUP 
autocmd!
autocmd filetype python nnoremap <buffer> <localleader>ef :sp term://python3 %<CR>
autocmd filetype lua nnoremap <buffer> <localleader>ef :luafile %<CR>
autocmd filetype TelescopePrompt let b:autopairs_enabled = 0
augroup END 
]]
-- ============= completion =============================
local cmp = require "cmp"
cmp.setup {
    snippet = { expand = function() end },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true, },
        -- ['<Tab>'] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif luasnip.expand_or_jumpable() then
        --         luasnip.expand_or_jump()
        --     else
        --         fallback()
        --     end
        -- end, { 'i', 's' }),
        -- ['<S-Tab>'] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif luasnip.jumpable(-1) then
        --         luasnip.jump(-1)
        --     else
        --         fallback()
        --     end
        -- end, { 'i', 's' }),
    },
    sources = {
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lsp' },
    },
}
-- ===============================lsp==========================
require('neodev').setup()
require("mason").setup()
local mason_lsp = require("mason-lspconfig")
mason_lsp.setup()
local on_attach = function(_, bufnr)
    vim.keymap.set('n', '<localleader>K', vim.lsp.buf.hover, {buffer = bufnr})
    vim.keymap.set('n', '<localleader>gd', vim.lsp.buf.definition, {buffer = bufnr})
    vim.keymap.set('n', '<localleader>gr', tel_builtin.lsp_references, {buffer = bufnr})
    vim.keymap.set('n', '<localleader>gq', tel_builtin.diagnostics, {buffer = bufnr})
    vim.keymap.set('n', '<localleader>ds', tel_builtin.lsp_document_symbols, {buffer = bufnr})
    vim.keymap.set('n', '<localleader>ps', tel_builtin.lsp_workspace_symbols, {buffer = bufnr})
    vim.keymap.set('n', '<localleader>rr', vim.lsp.buf.rename, {buffer = bufnr})
    vim.keymap.set('n', '<localleader>ac', vim.lsp.buf.code_action, {buffer = bufnr})
    vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, {buffer = bufnr})
    vim.keymap.set('n', ']e', vim.diagnostic.goto_next, {buffer = bufnr})
end
local servers = {
    sumneko_lua = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
mason_lsp.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name]
        }
    end,
}
-- ============================================================
