local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('@function.macro.rust', C.aurora_purple, '', { bold = true })
end

return M
