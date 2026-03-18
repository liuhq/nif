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
    signs_staged_enable = true,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
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
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
    },
    on_attach = function (bufnr)
        local gs = require('gitsigns')

        vim.keymap.set('n', '[g', function () gs.nav_hunk('prev') end,
            { buffer = bufnr, desc = 'Prev hunk' })
        vim.keymap.set('n', ']g', function () gs.nav_hunk('next') end,
            { buffer = bufnr, desc = 'Next hunk' })
        vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })
        vim.keymap.set('n', '<leader>gb', function () gs.blame_line({ full = true }) end,
            { buffer = bufnr, desc = 'Blame line' })
        vim.keymap.set('n', '<leader>ga', gs.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle blame' })
        vim.keymap.set('n', '<leader>gd', gs.diffthis, { buffer = bufnr, desc = 'Diff latest (HEAD)' })
        vim.keymap.set('n', '<leader>gD', function () gs.diffthis('~') end,
            { buffer = bufnr, desc = 'Diff last (HEAD~1)' })
        vim.keymap.set('n', '<leader>gr', gs.toggle_deleted, { buffer = bufnr, desc = 'Show deleted' })
    end,
})

vim.keymap.set('n', '<leader>gh', '<cmd>Gitsigns toggle_signs<cr>', { desc = 'Toggle git signs' })
