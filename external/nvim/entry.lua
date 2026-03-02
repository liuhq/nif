-- Checkhealth advice to disable
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
-- netrw disabled --
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require 'base'
require 'plug-deps'
require 'lsp'
require 'plug-local'

vim.cmd.colorscheme 'nordust'
