---@type vim.lsp.Config
return {
    filetypes = { 'bash', 'sh', 'zsh' },
    single_file_support = true,
    settings = {
        bashIde = {
            globPattern = '*@(.sh|.inc|.bash|.command)',
            shfmt = {
                path = vim.fn.exepath('shfmt'),
                binaryNextLine = true,
                ignoreEditorconfig = false,
            },
            shellcheckPath = 'shellcheck',
            shellcheckArguments = '',
        },
    },
}
