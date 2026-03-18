local icons = ConfigUtil.icons

require('gitsigns').setup({
    signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
    },
    signs_staged = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
    },
    status_formatter = function (status)
        local added, changed, removed = status.added, status.changed, status.removed
        local status_txt = {}
        if added and added > 0 then
            table.insert(status_txt,
                '%#GitSignsAdd#' .. icons.git.added .. ' ' .. added .. '%*')
        end
        if changed and changed > 0 then
            table.insert(status_txt,
                '%#GitSignsChange#' .. icons.git.changed .. ' ' .. changed .. '%*')
        end
        if removed and removed > 0 then
            table.insert(status_txt,
                '%#GitSignsDelete#' .. icons.git.removed .. ' ' .. removed .. '%*')
        end
        return table.concat(status_txt, ' ')
    end,
    preview_config = {
        border = 'single',
    },
    on_attach = function (bufnr)
        local gs = require('gitsigns')

        vim.keymap.set('n', '[g', function () gs.nav_hunk('prev') end,
            { buffer = bufnr, desc = 'Prev hunk' })
        vim.keymap.set('n', ']g', function () gs.nav_hunk('next') end,
            { buffer = bufnr, desc = 'Next hunk' })
        vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview hunk floating' })
        vim.keymap.set('n', '<leader>gb', function () gs.blame_line({ full = true }) end,
            { buffer = bufnr, desc = 'Blame line' })
        vim.keymap.set('n', '<leader>ga', gs.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle blame' })
        vim.keymap.set('n', '<leader>gd', gs.diffthis, { buffer = bufnr, desc = 'Diff latest (HEAD)' })
        vim.keymap.set('n', '<leader>gD', function () gs.diffthis('~') end,
            { buffer = bufnr, desc = 'Diff last (HEAD~1)' })
        vim.keymap.set('n', '<leader>gr', gs.preview_hunk_inline, { buffer = bufnr, desc = 'Preview hunk inline' })
        vim.keymap.set('n', '<leader>gc', function ()
            gs.show_commit('HEAD', 'vsplit')
        end, { buffer = bufnr, desc = 'Show revision HEAD commit' })
        vim.keymap.set('n', '<leader>gs', gs.stage_hunk, { buffer = bufnr, desc = 'Toggle staged hunk' })
    end,
})

vim.keymap.set('n', '<leader>gh', '<cmd>Gitsigns toggle_signs<cr>', { desc = 'Toggle git signs' })
