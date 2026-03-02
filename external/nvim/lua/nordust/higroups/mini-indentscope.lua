local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('MiniIndentscopeSymbol', { link = 'Comment' })
end

return M

