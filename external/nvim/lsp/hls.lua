---@type vim.lsp.Config
return {
    settings = {
        haskell = {
            formattingProvider = 'ormolu',
            cabalFormattingProvider = 'cabal-gild',
        },
    },
}
