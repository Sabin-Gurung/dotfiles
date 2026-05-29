require('neodev').setup()
require("mason").setup()
local tel_builtin = require("telescope.builtin")
local mason_lsp = require("mason-lspconfig")
mason_lsp.setup()

-- Modern way to handle on_attach keybindings
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local bufnr = ev.buf
        vim.keymap.set('n', '<localleader>K', vim.lsp.buf.hover, {buffer = bufnr, desc = "telescope hover documentation"})
        vim.keymap.set('n', '<localleader>gd', vim.lsp.buf.definition, {buffer = bufnr, desc = "lsp definition"})
        vim.keymap.set('n', '<localleader>gr', tel_builtin.lsp_references, {buffer = bufnr, desc = "telescope lsp_references"})
        vim.keymap.set('n', '<localleader>gq', tel_builtin.diagnostics, {buffer = bufnr, desc = "telescope diagnostics"})
        vim.keymap.set('n', '<localleader>ds', tel_builtin.lsp_document_symbols, {buffer = bufnr, desc = "telescope lsp_document_symbols"})
        vim.keymap.set('n', '<localleader>ps', tel_builtin.lsp_workspace_symbols, {buffer = bufnr, desc = "telescope lsp_workspace_symbols"})
        vim.keymap.set('n', '<localleader>rr', vim.lsp.buf.rename, {buffer = bufnr, desc = "lsp rename"})
        vim.keymap.set('n', '<localleader>ac', vim.lsp.buf.code_action, {buffer = bufnr, desc = "lsp quick actions"})
        vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, {buffer = bufnr, desc = "lsp diagnostics.goto_next"})
        vim.keymap.set('n', ']e', vim.diagnostic.goto_next, {buffer = bufnr, desc = "lsp diagnostics.goto_prev"})
    end,
})

local servers = {
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
                globals = { 'vim' }
            }
        },
    },
}

-- Set global defaults for all servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.lsp.config('*', {
    capabilities = capabilities,
})

-- Configure specific servers with their settings
for server, settings in pairs(servers) do
    vim.lsp.config(server, {
        settings = settings,
    })
end

-- mason-lspconfig with automatic_enable=true (default) will 
-- automatically call vim.lsp.enable(server) for installed servers.


