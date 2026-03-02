local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('TSModuleInfoGood', { link = 'DiagnosticOk' })
    hl('TSModuleInfoBad', { link = 'DiagnosticError' })
end

return M
