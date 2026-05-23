---@type vim.lsp.Config
return {
    settings = {
        schema = {
            enabled = true,
            associations = {
                ['Cargo.toml'] = 'https://www.schemastore.org/cargo.json',
            },
        },
    },
}
