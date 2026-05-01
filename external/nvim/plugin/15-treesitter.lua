local lang_set = {}

local ts_group = vim.api.nvim_create_augroup('TSSetup', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group = ts_group,
    -- pattern = lang_set,
    pattern = '*',
    callback = function (evt)
        local buf = evt.buf
        local filetype = evt.match

        if vim.api.nvim_buf_line_count(buf) > 10000 then
            return
        end

        local lang = vim.treesitter.language.get_lang(filetype) or filetype
        if not vim.treesitter.language.add(lang) then
            return
        end

        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

        vim.treesitter.start(buf, lang)
        vim.keymap.set('n', '<leader>fh', function ()
            vim.treesitter.stop(buf)
        end, { desc = 'Stop TS highlight', buf = buf })
    end,
})

---@diagnostic disable-next-line: missing-fields
require('nvim-ts-autotag').setup({
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
    },
})

vim.keymap.set('n', 'zS', vim.show_pos, { desc = 'Inspect token' })
vim.keymap.set('n', 'zT', vim.treesitter.inspect_tree, { desc = 'Inspect token tree' })
