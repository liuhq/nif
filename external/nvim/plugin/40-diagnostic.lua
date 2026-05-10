local icons = ConfigUtil.icons
local borders = {
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
    { ' ', 'NormalFloat' },
}

vim.diagnostic.config({
    virtual_text = {
        severity = {
            max = vim.diagnostic.severity.WARN,
        },
        prefix = icons.diagnostics.Sign,
        virt_text_pos = 'eol_right_align',
    },
    virtual_lines = {
        severity = {
            min = vim.diagnostic.severity.ERROR,
        },
        current_line = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
    },
    float = {
        scope = 'cursor',
        border = borders,
    },
    severity_sort = true,
})

vim.keymap.set('n', '<leader>dh', function ()
    local bufnr = vim.api.nvim_get_current_buf()
    local is_enabled = vim.diagnostic.is_enabled({ bufnr = bufnr })

    vim.notify(is_enabled
        and 'Diagnostic: disabled'
        or 'Diagnostic: enabled',
        vim.log.levels.INFO,
        { group = 'Diagnostic Show', skip_history = true })

    vim.diagnostic.enable(not is_enabled, { bufnr = bufnr })
end, { desc = 'Toggle diagnostic' })
