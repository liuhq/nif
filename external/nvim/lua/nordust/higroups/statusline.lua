local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('StatusLine', C.frost_1_primary, C.night_0)
    hl('StatusLineNC', { link = 'StatusLine' })
    hl('StatusLineTerm', { link = 'StatusLine' })
    hl('StatusLineTermNC', { link = 'StatusLine' })

    hl('StatusLineModeNormal', C.night_0, C.frost_1_primary)
    hl('StatusLineModeInsert', C.night_0, C.snow_1)
    hl('StatusLineModeVisual', C.night_0, C.frost_2)
    hl('StatusLineModeReplace', C.night_0, C.aurora_orange)
    hl('StatusLineModeCommand', C.night_0, C.aurora_purple)
    hl('StatusLineModeDefault', { link = 'StatusLineModeNormal' })
    hl('StatusLineSecondary', C.snow_1, C.night_1)
    hl('StatusLineFlags', C.aurora_yellow, '')
    hl('StatusLineDiagError', { link = 'DiagnosticError' })
    hl('StatusLineDiagWarn', { link = 'DiagnosticWarn' })
    hl('StatusLineDiagInfo', { link = 'DiagnosticInfo' })
    hl('StatusLineDiagHint', { link = 'DiagnosticHint' })
end

return M
