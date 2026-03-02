-- leader key --
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local keymap = vim.keymap

--[[
--  Note:
--      1. ! - run program
--      2. @ - call the macro records
--      3. */# - search backward/forward for the word under the cursor
--      4. % - jump between surround
--  Mode:
--      v -- Visual & Select
--      x -- Visual
--      s -- Select
--      c -- Cmdline
--]]

keymap.set('n', '<esc>', function ()
    vim.cmd('nohlsearch')
end, { silent = true, desc = 'Clear hlsearch' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap.set('n', 'n', function ()
    vim.api.nvim_feedkeys(vim.v.searchforward == 1 and 'n' or 'N' .. 'zv', 'n', false)
end, { silent = true, desc = 'Better Next Search' })
keymap.set({ 'x', 'o' }, 'n', function ()
    vim.api.nvim_feedkeys(vim.v.searchforward == 1 and 'n' or 'N', 'n', false)
end, { silent = true, desc = 'Better Next Search' })
keymap.set('n', 'N', function ()
    vim.api.nvim_feedkeys(vim.v.searchforward == 1 and 'N' or 'n' .. 'zv', 'n', false)
end, { silent = true, desc = 'Better Prev Search' })
keymap.set({ 'x', 'o' }, 'N', function ()
    vim.api.nvim_feedkeys(vim.v.searchforward == 1 and 'N' or 'n', 'n', false)
end, { silent = true, desc = 'Better Prev Search' })

-- without yank --
keymap.set('x', 'd', '"_d', { remap = false, silent = true })
keymap.set({ 'n', 'x' }, '<leader>p', '"0p', { desc = 'Paste Reg 0', remap = false, silent = true })
keymap.set({ 'n', 'x' }, 'c', '"_c', { remap = false, silent = true })

-- better up/down
keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Cursor Down', expr = true, silent = true })
keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Cursor Up', expr = true, silent = true })

-- better jump to line start/end
-- "jump to start" handled by local-linestart-jump in normal mode
-- keymap.set('n', 'H', '^', { desc = 'Cursor Start', remap = true, silent = true })
keymap.set('n', 'gl', '$', { desc = 'Cursor End', remap = true, silent = true })
keymap.set('x', 'gh', '^', { desc = 'Cursor Start', remap = true, silent = true })
keymap.set('x', 'gl', '$h', { desc = 'Cursor End', remap = true, silent = true })

-- save file
keymap.set('n', '<leader><cr>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- better indenting
keymap.set('x', '<', '<gv')
keymap.set('x', '>', '>gv')

-- quit
keymap.set('n', '<C-Q>', '<cmd>qa<cr>', { desc = 'Quit' })

-- windows
keymap.set('n', '<C-W>b', '<cmd>vertical ball 2<cr>', { desc = 'Vertical Split 2 Buffers' })

-- move to window using the <ctrl> hjkl keys
keymap.set('n', '<C-H>', '<cmd>wincmd h<cr>', { desc = 'Go to Left Window' })
keymap.set('n', '<C-J>', '<cmd>wincmd j<cr>', { desc = 'Go to Lower Window' })
keymap.set('n', '<C-K>', '<cmd>wincmd k<cr>', { desc = 'Go to Upper Window' })
keymap.set('n', '<C-L>', '<cmd>wincmd l<cr>', { desc = 'Go to Right Window' })

-- resize window using <ctrl> arrow keys
keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

--- handled by mini.bufremove
-- keymap.set('n', '<leader>x', '<cmd>bdelete<cr>', { desc = 'Delete Buffer' })

keymap.set('n', 'g.', 'gi', { desc = 'Jump to Last Insert' })

keymap.set({ 'n', 'x' }, 'K', 'i<cr><esc>', { remap = false, silent = true })

-- mock emacs in insert and cmdline
keymap.set('i', '<C-f>', '<Right>', { remap = false, silent = true })
keymap.set('i', '<C-b>', '<Left>', { remap = false, silent = true })
keymap.set('i', '<C-a>', '<Home>', { remap = false, silent = true })
keymap.set('i', '<C-e>', '<End>', { remap = false, silent = true })
