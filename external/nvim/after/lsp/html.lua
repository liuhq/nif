local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
    capabilities = capabilities,
    ---@type lspconfig.settings.html
    settings = {
        html = {
            format = {
                wrapLineLength = 80,
            },
        },
    },
}
