local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('@function.macro.rust', C.frost_3, '', { bold = true })
end

return M
