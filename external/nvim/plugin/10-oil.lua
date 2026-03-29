-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = require('oil').get_current_dir(bufnr)
    if dir then
        return vim.fn.fnamemodify(dir, ':~')
    else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
    end
end

local oil = require('oil')

oil.setup({
    delete_to_trash = true,
    columns = {},
    lsp_file_methods = {
        autosave_changes = 'unmodified',
    },
    watch_for_changes = true,
    use_default_keymaps = false,
    keymaps = {
        ['g?'] = { 'actions.show_help', mode = 'n', desc = 'Help' },
        ['L'] = { 'actions.select', mode = 'n' },
        ['<C-W><C-V>'] = {
            function ()
                oil.select({ vertical = true })
                oil.close()
            end,
            mode = 'n',
            desc = 'Vertical split',
        },
        ['<C-W><C-S>'] = {
            function ()
                oil.select({ horizontal = true })
                oil.close()
            end,
            mode = 'n',
            desc = 'Horizontal split',
        },
        ['<C-T>'] = { 'actions.select', opts = { tab = true }, mode = 'n', desc = 'Open in new tabpage' },
        ['<tab>'] = { 'actions.preview', mode = 'n', desc = 'Toggle Preview' },
        ['<C-C>'] = { 'actions.close', mode = 'n', desc = 'Close oil' },
        ['gr'] = { 'actions.refresh', mode = 'n', desc = 'Refresh' },
        ['H'] = { 'actions.parent', mode = 'n', desc = 'Back to parent' },
        ['<backspace>'] = { 'actions.open_cwd', mode = 'n', desc = 'Open in CWD' },
        ['gc'] = { 'actions.cd', mode = 'n', desc = 'Change CWD' },
        ['gt'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n', desc = 'Change CWD in tabpage scope' },
        ['gm'] = { 'actions.change_sort', mode = 'n', desc = 'Change sort mode' },
        ['gx'] = { 'actions.open_external', mode = 'n', desc = 'Open via external' },
        ['g.'] = { 'actions.toggle_hidden', mode = 'n', desc = 'Toggle hidden' },
        ['\\\\'] = { 'actions.toggle_trash', mode = 'n', desc = 'Toggle trash' },

        ['<leader><cr>'] = {
            function ()
                oil.save()
            end,
            mode = 'n',
            desc = 'Save oil changes',
        },
        ['<leader><backspace>'] = {
            function ()
                oil.discard_all_changes()
            end,
            mode = 'n',
            desc = 'Discard all oil changes',
        },
        ['gy'] = { 'actions.yank_entry', mode = 'n' },
        ['J'] = { 'actions.preview_scroll_down', mode = 'n', desc = 'Preview scroll down' },
        ['K'] = { 'actions.preview_scroll_up', mode = 'n', desc = 'Preview scroll up' },
        ['gd'] = {
            function ()
                vim.g.oil_detail = not vim.g.oil_detail
                if vim.g.oil_detail then
                    oil.set_columns({ 'permissions', 'size', 'mtime' })
                else
                    oil.set_columns({})
                end
            end,
            mode = 'n',
            desc = 'Toggle file detail view',
        },
    },
    win_options = {
        winbar = '%!v:lua.get_oil_winbar()',
    },
    float = {
        border = 'solid',
        get_win_title = function ()
            return ''
        end,
    },
    confirmation = {
        border = 'solid',
        win_options = {
            winblend = 10,
        },
    },
    ssh = {
        border = 'solid',
    },
    keymaps_help = {
        border = 'solid',
    },
})

vim.keymap.set('n', '<leader>o', function ()
    local buf_name = vim.api.nvim_buf_get_name(0)
    local is_oil = vim.startswith(buf_name, 'oil')
    if is_oil then
        oil.close({ exit_if_last_buf = true })
    else
        oil.open(oil.get_current_dir(0), { preview = { vertical = true } })
    end
end, { desc = 'Oil' })
vim.keymap.set('n', '<leader>O', function ()
    local buf_name = vim.api.nvim_buf_get_name(0)
    local is_oil = vim.startswith(buf_name, 'oil')
    if is_oil then
        oil.close({ exit_if_last_buf = true })
    else
        oil.open(vim.uv.cwd(), { preview = { vertical = true } })
    end
end, { desc = 'Oil (CWD)' })
