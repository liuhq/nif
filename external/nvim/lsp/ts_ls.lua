return {
    single_file_support = false,
    settings = {
        javascript = {
            format = {
                semicolons = 'remove',
            },
            inlayHints = {
                functionLikeReturnTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
            },
            preferGoToSourceDefinition = true,
            preferences = {
                quoteStyle = 'single',
            },
        },
        typescript = {
            format = {
                semicolons = 'remove',
            },
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
            },
            preferGoToSourceDefinition = true,
            preferences = {
                preferTypeOnlyAutoImports = true,
                quoteStyle = 'single',
            },
            tsserver = {
                experimental = {
                    enableProjectDiagnostics = true,
                },
            },
        },
    },
}
