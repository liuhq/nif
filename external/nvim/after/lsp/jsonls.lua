local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
    capabilities = capabilities,
    ---@type lspconfig.settings.jsonls
    settings = {
        json = {
            schemas = {
                {
                    fileMatch = { 'package.json' },
                    url = 'https://schemastore.org/package.json',
                },
                {
                    fileMatch = { 'tsconfig*.json' },
                    url = 'https://schemastore.org/tsconfig.json',
                },
                {
                    fileMatch = { 'deno.json', 'deno.jsonc' },
                    url =
                    'https://raw.githubusercontent.com/denoland/deno/refs/heads/main/cli/schemas/config-file.v1.json',
                },
                {
                    fileMatch = {
                        '.prettierrc',
                        '.prettierrc.json',
                        'prettier.config.json',
                    },
                    url = 'https://schemastore.org/prettierrc.json',
                },
                {
                    fileMatch = { '.eslintrc', '.eslintrc.json' },
                    url = 'https://schemastore.org/eslintrc.json',
                },
                {
                    fileMatch = {
                        'dprint.json',
                        'dprint.jsonc',
                        '.dprint.json',
                        '.dprint.jsonc',
                    },
                    url = 'https://dprint.dev/schemas/v0.json',
                },
            },
        },
    },
}
