local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('WhichKeyGroup', C.frost_1_primary, '')
    hl('WhichKeyIcon', C.frost_0_secondary, '')
    hl('WhichKeyValue', C.snow_0, '')
end

return M
