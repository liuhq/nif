-- Line Start Jump (link vscode) --
vim.api.nvim_create_user_command('CursorToLineStart', function ()
    local head = (vim.api.nvim_get_current_line():find('[^%s]') or 1) - 1
    local cursor = vim.api.nvim_win_get_cursor(0)
    cursor[2] = cursor[2] == head and 0 or head
    vim.api.nvim_win_set_cursor(0, cursor)
end, {})

vim.keymap.set({ 'n', 'i' }, '<Home>', '<cmd>CursorToLineStart<cr>', { desc = 'Jump to Line Start' })
vim.keymap.set('n', 'gh', '<cmd>CursorToLineStart<cr>', { desc = 'Jump to Line Start' })
