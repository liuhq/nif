local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
    capabilities = capabilities,
    ---@type lspconfig.settings.jsonls
    settings = {
        json = {
            colorDecorators = { enable = true },
            schemaDownload = { enable = true },
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
}
