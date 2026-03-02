vim.o.timeout = true
vim.o.timeoutlen = 300

local wk = require('which-key')
wk.setup({
    preset = 'helix',
    delay = 0,
    notify = true,
    icons = {
        rules = false,
    },
    win = {
        border = false,
        padding = { 1, 2 },
    },
    sort = { 'order', 'group', 'alphanum', 'mod' },
})
wk.add({
    { 'g', group = 'Goto', mode = { 'n', 'v' } },
    { 'z', group = 'Fold', mode = { 'n', 'v' } },
    { '[', group = 'Prev', mode = { 'n', 'v' } },
    { ']', group = 'Next', mode = { 'n', 'v' } },
    { '[d', desc = 'Prev Diagnostic' },
    { ']d', desc = 'Next Diagnostic' },
    { '[D', desc = 'First Diagnostic' },
    { ']D', desc = 'Last Diagnostic' },
    { '[f', desc = 'Prev Function Start' },
    { ']f', desc = 'Next Function Start' },
    { '[F', desc = 'Prev Function End' },
    { ']F', desc = 'Next Function End' },
    { '<leader>a', group = 'Manager' },
    { '<leader>c', group = 'Code' },
    { '<leader>d', group = 'Diagnostics' },
    { '<leader>f', group = 'File' },
    { '<leader>g', group = 'Git' },
    { '<leader>n', group = 'Notification' },
    { '<leader>s', group = 'Search' },
    { '<leader>v', group = 'Dap' },
})
