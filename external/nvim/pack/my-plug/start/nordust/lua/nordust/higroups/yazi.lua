local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('YaziFloat', { link = 'Normal' })
    hl('YaziFloatBorder', { link = 'YaziFloat' })
end

return M
