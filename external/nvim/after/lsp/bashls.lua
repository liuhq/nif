---@type vim.lsp.Config
return {
    filetypes = { 'bash', 'sh' },
    ---@type lspconfig.settings.bashls
    settings = {
        bashIde = {
            globPattern = '*@(.sh|.inc|.bash|.command)',
            shfmt = {
                path = 'shfmt',
                binaryNextLine = true,
                ignoreEditorconfig = false,
            },
            shellcheckPath = 'shellcheck',
            shellcheckArguments = '',
        },
    },
}
