local icons = ConfigUtil.icons

require('fzf-lua').setup({
    winopts = {
        row = 0.50,
        col = 0.50,
        border = 'solid',
        preview = {
            border = 'solid',
            vertical = 'down:45%',
            horizontal = 'right:45%',
            layout = 'flex',
        },
    },
    lsp = {
        symbols = {
            symbol_style = 3,
        },
    },
    diagnostics = {
        signs = {
            ['Error'] = { text = icons.diagnostics.Error },
            ['Warn'] = { text = icons.diagnostics.Warn },
            ['Hint'] = { text = icons.diagnostics.Hint },
            ['Info'] = { text = icons.diagnostics.Info },
        },
    },
})

vim.keymap.set('n', '<leader><space>', function ()
    require('fzf-lua').files()
end, { desc = 'Files' })
vim.keymap.set('n', '<leader>b', function ()
    require('fzf-lua').buffers()
end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fs', function ()
    require('fzf-lua').treesitter()
end, { desc = 'Treesitter Symbols' })
vim.keymap.set('n', '<leader>ft', function ()
    require('fzf-lua').filetypes()
end, { desc = 'Filetypes' })
vim.keymap.set('n', '<leader>ss', function ()
    require('fzf-lua').grep()
end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>sS', function ()
    require('fzf-lua').live_grep()
end, { desc = 'Live Grep Current Project' })
vim.keymap.set('n', '<leader>sc', function ()
    require('fzf-lua').grep_cword()
end, { desc = 'Search Word Under Cursor' })
vim.keymap.set('n', '<leader>cr', function ()
    require('fzf-lua').lsp_references({ ignore_current_line = true })
end, { desc = 'LSP References' })
vim.keymap.set('n', '<leader>cd', function ()
    require('fzf-lua').lsp_document_symbols()
end, { desc = 'LSP Document Symbols' })
vim.keymap.set('n', '<leader>df', function ()
    require('fzf-lua').diagnostics_document()
end, { desc = 'Current File Diagnostics' })
vim.keymap.set('n', '<leader>dw', function ()
    require('fzf-lua').diagnostics_workspace()
end, { desc = 'Workspace Diagnostics' })
vim.keymap.set({ 'x', 'i' }, '<C-p>', function ()
    local save_dir = vim.fn.chdir(vim.fn.expand('%:p:h'))
    if save_dir ~= '' then
        require('fzf-lua').complete_path()
        vim.fn.chdir(save_dir)
    end
end, { desc = 'Fuzzy Complete Path' })
