----------------------------------------\\
-- Checkhealth advice to disable
----------------------------------------//
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
-- netrw disabled --
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


----------------------------------------\\
-- Options
----------------------------------------//
local o = vim.o

o.exrc = true

o.clipboard = 'unnamedplus'
o.cursorline = true
o.number = true
o.relativenumber = true
o.numberwidth = 4

o.autoindent = true
o.smartindent = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2

o.colorcolumn = '80,120'

o.confirm = true
o.mouse = 'a'
o.scrolljump = 1
o.scrolloff = 5
o.smoothscroll = true
o.virtualedit = 'block'

o.sessionoptions = 'blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,terminal,winpos,winsize'
o.smartcase = true
o.incsearch = true
o.splitbelow = true
o.splitright = true

o.winblend = 10
o.wildmenu = true
o.wildoptions = 'fuzzy,pum,tagfile'
o.wildmode = 'noselect:full'
o.pumblend = 12
o.pumheight = 10
o.completeopt = 'menu,menuone,popup,noinsert,noselect,fuzzy'

o.guicursor = 'n-o:block,v-c:hor18,i-ci-ve:ver10,r-cr-sm:block,a:blinkwait700-blinkoff400-blinkon250'
o.laststatus = 3
o.showmode = false
o.termguicolors = true
o.winminwidth = 5
o.foldlevel = 99

o.wrap = false
o.whichwrap = '<,>,[,]'

vim.g.encoding = 'UTF-8'
o.fileencoding = 'UTF-8'
o.fileformat = 'unix'
o.fileformats = 'unix,dos'

--- default: l t T o O C F
vim.opt.shortmess:append({
    l = false,
    W = true,
    I = true,
    c = true,
    C = true,
    S = true,
    s = true,
})

o.undofile = true
o.undolevels = 10000
o.updatetime = 200


----------------------------------------\\
-- Autocmd
----------------------------------------//
local cursor_group = vim.api.nvim_create_augroup('CursorGroup', { clear = true })
-- restore cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
    group = cursor_group,
    callback = function ()
        local line = vim.fn.line('\'"')
        if line > 1 and line <= vim.fn.line('$') then
            vim.cmd.normal('g\'"')
        end
    end,
})

-- VimLeave * set guicursor= | call chansend(v:stderr, "\x1b[ q")
vim.api.nvim_create_autocmd('VimLeave', {
    group = cursor_group,
    callback = function ()
        vim.o.guicursor = ''
        vim.fn.chansend(vim.v.stderr, '\x1b[ q')
    end,
})

-- the cursor will redraw its shape when neovim is suspended or resumed
vim.api.nvim_create_autocmd('VimSuspend', {
    group = cursor_group,
    callback = function ()
        vim.o.guicursor = ''
        vim.fn.chansend(vim.v.stderr, '\x1b[ q')
        vim.cmd("silent !echo -ne '\\e[0 q'")
    end,
})
vim.api.nvim_create_autocmd('VimResume', {
    group = cursor_group,
    callback = function ()
        vim.o.guicursor = 'n-o:block,v-c:hor18,i-ci-ve:ver10,r-cr-sm:block,a:blinkwait700-blinkoff400-blinkon250'
    end,
})

-- highlight after copy
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('YankHighlightGroup', { clear = true }),
    callback = function ()
        vim.hl.on_yank({
            timeout = 100,
        })
    end,
})


----------------------------------------\\
-- Keymaps
----------------------------------------//
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
end, { silent = true, desc = 'Better next search' })
keymap.set({ 'x', 'o' }, 'n', function ()
    vim.api.nvim_feedkeys(vim.v.searchforward == 1 and 'n' or 'N', 'n', false)
end, { silent = true, desc = 'Better next search' })
keymap.set('n', 'N', function ()
    vim.api.nvim_feedkeys(vim.v.searchforward == 1 and 'N' or 'n' .. 'zv', 'n', false)
end, { silent = true, desc = 'Better prev search' })
keymap.set({ 'x', 'o' }, 'N', function ()
    vim.api.nvim_feedkeys(vim.v.searchforward == 1 and 'N' or 'n', 'n', false)
end, { silent = true, desc = 'Better prev search' })

-- without yank --
keymap.set('x', 'd', '"_d', { remap = false, silent = true })
keymap.set({ 'n', 'x' }, '<leader>p', '"0p', { desc = 'Paste reg 0', remap = false, silent = true })
keymap.set({ 'n', 'x' }, 'c', '"_c', { remap = false, silent = true })

-- better up/down
keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Cursor down', expr = true, silent = true })
keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Cursor up', expr = true, silent = true })

-- better jump to line start/end
-- "jump to start" handled by local-linestart-jump in normal mode
-- keymap.set('n', 'H', '^', { desc = 'Cursor start', remap = true, silent = true })
keymap.set('n', 'gl', '$', { desc = 'Cursor end', remap = true, silent = true })
keymap.set('x', 'gh', '^', { desc = 'Cursor start', remap = true, silent = true })
keymap.set('x', 'gl', '$h', { desc = 'Cursor end', remap = true, silent = true })

-- save file
keymap.set('n', '<leader><cr>', '<cmd>w<cr><esc>', { desc = 'Save file' })

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
keymap.set('n', 'gn', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
keymap.set('n', 'gp', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })

keymap.set('n', '<leader>j', 'gi', { desc = 'Jump to Last Insert' })

keymap.set({ 'n', 'x' }, 'K', 'i<cr><esc>', { remap = false, silent = true })

-- mock emacs in insert and cmdline
keymap.set('i', '<C-j>', '<Down>', { remap = false, silent = true })
keymap.set('i', '<C-k>', '<Up>', { remap = false, silent = true })
keymap.set('i', '<C-f>', '<Right>', { remap = false, silent = true })
keymap.set('i', '<C-b>', '<Left>', { remap = false, silent = true })
keymap.set('i', '<C-a>', '<Home>', { remap = false, silent = true })
keymap.set('i', '<C-e>', '<End>', { remap = false, silent = true })


----------------------------------------\\
-- Global variables for lua
----------------------------------------//
local ConfigUtil = {}
_G.ConfigUtil = ConfigUtil

ConfigUtil.icons = {
    dap = {
        Stopped = '󰁕 ',
        Breakpoint = ' ',
        BreakpointCondition = ' ',
        LogPoint = ' ',
    },
    diagnostics = {
        Sign = '▪',
        Error = '',
        Warn = '',
        Info = '',
        Hint = '',
    },
    git = {
        added = '󰐕',
        changed = '󰧞',
        removed = '󰍴',
    },
    file_status = {
        modified = '',
        readonly = '󰌾',
        unnamed = '󰜥',
        newfile = '󰈔',
    },
}


----------------------------------------\\
-- Colorscheme
----------------------------------------//
vim.cmd.colorscheme 'nordust'
