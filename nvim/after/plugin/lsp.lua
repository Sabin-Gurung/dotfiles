require('neodev').setup()
require("mason").setup()
local tel_builtin = require("telescope.builtin")
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

