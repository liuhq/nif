require('nvim-surround').setup()

-- enable ar for ysarb
vim.keymap.set('o', 'ir', 'i[')
vim.keymap.set('o', 'ar', 'a[')
vim.keymap.set('o', 'ia', 'i<')
vim.keymap.set('o', 'aa', 'a<')
