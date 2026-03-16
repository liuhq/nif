---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.eslint
    settings = {
        eslint = {
            experimental = {
                useFlatConfig = true,
            },
            format = {
                enable = false,
            },
        },
    },
}
