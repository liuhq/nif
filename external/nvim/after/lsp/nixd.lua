---@type vim.lsp.Config
return {
    settings = {
        nixd = {
            formatting = {
                command = { 'nixfmt' },
            },
            nixpkgs = {
                expr = 'import (builtins.getFlake (toString ./.)).inputs.nixpkgs { }',
            },
        },
    },
}
