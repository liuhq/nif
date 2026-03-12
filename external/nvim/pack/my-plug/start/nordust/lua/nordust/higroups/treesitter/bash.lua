local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('@variable.parameter.followCommand.bash', C.frost_0_secondary, '')
    hl('@variable.parameter.path', { link = '@string.special.path' })
end

return M
