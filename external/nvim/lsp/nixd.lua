---@type vim.lsp.Config
return {
    single_file_support = true,
    settings = {
        nixd = {
            formatting = {
                command = { 'nixfmt' },
            },
        },
    },
}
