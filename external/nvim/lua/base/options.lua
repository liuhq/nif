local o = vim.o

o.exrc = true

o.clipboard = 'unnamedplus'
o.cursorline = true
o.number = true
o.relativenumber = false
o.numberwidth = 4

o.autoindent = true
o.smartindent = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

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
