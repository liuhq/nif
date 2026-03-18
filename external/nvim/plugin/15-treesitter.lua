---@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.configs').setup({
    -- ensure_installed = ts_lang,
    sync_install = true,
    highlight = {
        enable = true,
        disable = function (_, bufnr) -- Disable in large buffers
            return vim.api.nvim_buf_line_count(bufnr) > 50000
        end,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<leader>sn',
            node_incremental = '<space>',
            scope_incremental = false,
            node_decremental = '<bs>',
        },
    },
    textobjects = {
        move = {
            enable = true,
            goto_next_start = { [']f'] = '@function.outer' },
            goto_next_end = { [']F'] = '@function.outer' },
            goto_previous_start = { ['[f'] = '@function.outer' },
            goto_previous_end = { ['[F'] = '@function.outer' },
        },
    },
})

--- PERF: add nvim-treesitter custom query predicates early
require('nvim-treesitter.query_predicates')

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

---@diagnostic disable-next-line: missing-fields
require('nvim-ts-autotag').setup({
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
    },
})

vim.keymap.set('n', '<leader>ai', '<cmd>Inspect<cr>', { desc = 'Inspect token' })
vim.keymap.set('n', '<leader>at', '<cmd>InspectTree<cr>', { desc = 'Inspect token tree' })
