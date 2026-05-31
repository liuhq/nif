local mc = require('multicursor-nvim')

mc.setup()

local set = vim.keymap.set

set({ 'n', 'x' }, '<down>', function () mc.lineAddCursor(1) end, { desc = 'Add cursor below' })
set({ 'n', 'x' }, '<leader><down>', function () mc.lineSkipCursor(1) end, { desc = 'Skip cursor below' })
set({ 'n', 'x' }, '<up>', function () mc.lineAddCursor(-1) end, { desc = 'Add cursor above' })
set({ 'n', 'x' }, '<leader><up>', function () mc.lineSkipCursor(-1) end, { desc = 'Skip cursor above' })

set({ 'n', 'x' }, '<leader>mn', function () mc.matchAddCursor(1) end, { desc = 'Add cursor (next match)' })
set({ 'n', 'x' }, '<leader>mN', function () mc.matchSkipCursor(1) end, { desc = 'Skip cursor (next match)' })
set({ 'n', 'x' }, '<leader>mp', function () mc.matchAddCursor(-1) end, { desc = 'Add cursor (prev match)' })
set({ 'n', 'x' }, '<leader>mP', function () mc.matchSkipCursor(-1) end, { desc = 'Add cursor (prev match)' })

-- Add and remove cursors with control + left click.
set('n', '<c-leftmouse>', mc.handleMouse)
set('n', '<c-leftdrag>', mc.handleMouseDrag)
set('n', '<c-leftrelease>', mc.handleMouseRelease)

set('x', '<leader>ms', mc.splitCursors, { desc = 'Split selections by regex' })
set('x', '<leader>mr', mc.matchCursors, { desc = 'Match cursors within selections by regex' })
set('v', '<leader>mI', mc.insertVisual, { desc = '(I)nsert each line' })
set('v', '<leader>mA', mc.appendVisual, { desc = '(A)ppend each line' })

set('n', '<leader>mu', mc.restoreCursors, { desc = 'Restore cursors' })

mc.addKeymapLayer(function (layerSet)
    layerSet({ 'n', 'x' }, '<leader>p', mc.prevCursor, { desc = 'Prev cursor as main' })
    layerSet({ 'n', 'x' }, '<leader>n', mc.nextCursor, { desc = 'Next cursor as main' })
    layerSet('n', '<leader>a', mc.alignCursors, { desc = 'Align cursor columns' })
    layerSet({ 'n', 'x' }, '<leader>x', mc.deleteCursor, { desc = 'Delete main cursor' })

    layerSet('n', '<esc>', function ()
        if mc.hasCursors() then
            mc.clearCursors()
        end
    end)
end)
