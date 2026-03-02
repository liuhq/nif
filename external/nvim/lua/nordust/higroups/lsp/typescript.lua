local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('@lsp.typemod.interface.defaultLibrary.typescript', '', '', { bold = true })
    hl('@lsp.typemod.interface.defaultLibrary.typescriptreact', {
        link =
        '@lsp.typemod.interface.defaultLibrary.typescript',
    })
end

return M
