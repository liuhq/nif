local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('FlashMatch', C.frost_1_primary, '', { underline = true })
    hl('FlashCurrent', C.aurora_orange, '', { underline = true })
    hl('FlashLabel', C.snow_2, C.night_1, { bold = true })
end

return M
