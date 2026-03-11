vim.keymap.set('n', '<C-W>t', function ()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    if #wins < 2 then
        vim.notify('Toggle only works with exactly 2 windows', vim.log.levels.INFO)
        return
    end

    local info1 = vim.fn.getwininfo(wins[1])[1]
    local info2 = vim.fn.getwininfo(wins[2])[1]

    if info1.winrow == info2.winrow then
        vim.cmd('wincmd t | wincmd K')
    elseif info1.wincol == info2.wincol then
        vim.cmd('wincmd t | wincmd H')
    else
        vim.notify('Cannot determine layout', vim.log.levels.WARN)
    end
end, { desc = 'Toggle Split Orientation' })
