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
    { '[d', desc = 'Prev diagnostic' },
    { ']d', desc = 'Next diagnostic' },
    { '[D', desc = 'First diagnostic' },
    { ']D', desc = 'Last diagnostic' },
    { '[f', desc = 'Prev function start' },
    { ']f', desc = 'Next function start' },
    { '[F', desc = 'Prev function end' },
    { ']F', desc = 'Next function end' },
    { '<leader>a', group = 'Config' },
    { '<leader>c', group = 'Code' },
    { '<leader>d', group = 'Diagnostics' },
    { '<leader>f', group = 'File' },
    { '<leader>g', group = 'Git' },
    { '<leader>m', group = 'Multicursor', mode = { 'n', 'x' } },
    { '<leader>n', group = 'Notification' },
    { '<leader>s', group = 'Search' },
    { '<leader>t', group = 'Tab' },
    { '<leader>v', group = 'Dap', mode = { 'n', 'x' } },
})
