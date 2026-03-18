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
end, { desc = 'Treesitter symbols' })
vim.keymap.set('n', '<leader>ft', function ()
    require('fzf-lua').filetypes()
end, { desc = 'Filetypes' })
vim.keymap.set('n', '<leader>ss', function ()
    require('fzf-lua').grep()
end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>sS', function ()
    require('fzf-lua').live_grep()
end, { desc = 'Live grep current project' })
vim.keymap.set('n', '<leader>sc', function ()
    require('fzf-lua').grep_cword()
end, { desc = 'Search word under cursor' })
vim.keymap.set('n', '<leader>cr', function ()
    require('fzf-lua').lsp_references({ ignore_current_line = true })
end, { desc = 'LSP references' })
vim.keymap.set('n', '<leader>cd', function ()
    require('fzf-lua').lsp_document_symbols()
end, { desc = 'LSP document symbols' })
vim.keymap.set('n', '<leader>df', function ()
    require('fzf-lua').diagnostics_document()
end, { desc = 'Current file diagnostics' })
vim.keymap.set('n', '<leader>dw', function ()
    require('fzf-lua').diagnostics_workspace()
end, { desc = 'Workspace diagnostics' })
vim.keymap.set({ 'x', 'i' }, '<C-p>', function ()
    local save_dir = vim.fn.chdir(vim.fn.expand('%:p:h'))
    if save_dir ~= '' then
        require('fzf-lua').complete_path()
        vim.fn.chdir(save_dir)
    end
end, { desc = 'Fuzzy complete path' })
