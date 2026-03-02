local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('GitSignsAdd', { link = 'Added' })
    hl('GitSignsChange', { link = 'Changed' })
    hl('GitSignsDelete', { link = 'Removed' })

    hl('GitSignsAddInline', { link = 'Added' })
    hl('GitSignsChangeInline', { link = 'Changed' })
    hl('GitSignsDeleteInline', { link = 'Removed' })

    hl('GitSignsAddLnInline', { link = 'Added' })
    hl('GitSignsChangeLnInline', { link = 'Changed' })
    hl('GitSignsDeleteLnInline', { link = 'Removed' })

    hl('GitSignsAddVirtLnInline', C.aurora_green, C.night_0)
    hl('GitSignsChangeVirtLnInline', C.aurora_yellow, C.night_0)
    hl('GitSignsDeleteVirtLnInline', C.aurora_red, C.night_0)
end

return M
