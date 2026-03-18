local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set(
    'n',
    '<leader>k', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    function ()
        vim.cmd.RustLsp({ 'hover', 'actions' })
    end,
    { silent = true, buffer = bufnr, desc = 'LSP hover (Rust)' }
)

vim.keymap.set('n', '<leader>ct', function ()
        vim.cmd.RustLsp('testables')
    end,
    { silent = true, buffer = bufnr, desc = 'Run tests (Rust)' }
)

vim.keymap.set('n', '<leader>cT', function ()
        vim.cmd.RustLsp('relatedTests')
    end,
    { silent = true, buffer = bufnr, desc = 'Run related tests (Rust)' }
)

vim.keymap.set('n', '<leader>ce', function ()
        vim.cmd.RustLsp('expandMacro')
    end,
    { silent = true, buffer = bufnr, desc = 'Expand macro (Rust)' }
)

vim.keymap.set('n', '<leader>cM', function ()
        vim.cmd.RustLsp('rebuildProcMacros')
    end,
    { silent = true, buffer = bufnr, desc = 'Rebuild proc macros (Rust)' }
)

vim.keymap.set('n', '<leader>de', function ()
        vim.cmd.RustLsp('explainError')
    end,
    { silent = true, buffer = bufnr, desc = 'Explain error (Rust)' }
)

vim.keymap.set('n', '<leader>dc', function ()
        vim.cmd.RustLsp('renderDiagnostic')
    end,
    { silent = true, buffer = bufnr, desc = 'Render diagnostic (Rust)' }
)

vim.keymap.set('n', '<leader>dj', function ()
        vim.cmd.RustLsp('relatedDiagnostics')
    end,
    { silent = true, buffer = bufnr, desc = 'Jump to related diagnostics (Rust)' }
)

vim.keymap.set('n', '<leader>fc', function ()
        vim.cmd.RustLsp('openCargo')
    end,
    { silent = true, buffer = bufnr, desc = 'Open Cargo.toml (Rust)' }
)

vim.keymap.set('n', '<leader>fd', function ()
        vim.cmd.RustLsp('openDocs')
    end,
    { silent = true, buffer = bufnr, desc = 'Open docs.rs (Rust)' }
)
