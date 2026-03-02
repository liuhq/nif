local fidget = require('fidget')
local fidget_nt = require('fidget.notification')

fidget.setup {
    progress = {
        display = {
            done_icon = '',
            done_style = 'Comment',
            icon_style = 'DiagnosticInfo',
            overrides = {
                lua_ls = { name = 'lua ls' },
                rust_analyzer = { name = 'rust analyzer' },
            },
        },
    },
    notification = {
        override_vim_notify = true,
        configs = { default = vim.tbl_deep_extend('force', fidget_nt.default_config, { icon = '' }) },
        window = {
            winblend = 0,
            y_padding = 1,
        },
    },
}

vim.keymap.set('n', '<leader>na', '<cmd>Fidget clear<cr>', { desc = 'Clear Active' })
vim.keymap.set('n', '<leader>nc', '<cmd>Fidget clear_history<cr>', { desc = 'Clear Histories' })
vim.keymap.set('n', '<leader>nn', '<cmd>Fidget history<cr>', { desc = 'Show Histories' })
