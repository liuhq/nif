local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
    single_file_support = true,
    capabilities = capabilities,
    settings = {
        html = {
            format = {
                wrapLineLength = 80,
            },
        },
    },
}
