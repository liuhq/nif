local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('BlinkCmpLabelDeprecated', { link = 'Deprecated' })
    hl('BlinkCmpLabelDetail', C.night_3_bright, '')
    hl('BlinkCmpLabelDescription', C.night_3_bright, '')

    hl('BlinkCmpKindText', C.snow_0, '', { italic = true })
    hl('BlinkCmpKindMethod', C.frost_0_secondary, '', { italic = true })
    hl('BlinkCmpKindFunction', C.frost_0_secondary, '', { italic = true })
    hl('BlinkCmpKindConstructor', C.frost_1_primary, '', { bold = true, italic = true })
    hl('BlinkCmpKindField', C.snow_0, '', { italic = true })
    hl('BlinkCmpKindVariable', C.snow_0, '', { italic = true })
    hl('BlinkCmpKindClass', C.frost_0_secondary, '', { italic = true })
    hl('BlinkCmpKindInterface', C.frost_0_secondary, '', { italic = true })
    hl('BlinkCmpKindModule', C.frost_0_secondary, '', { italic = true })
    hl('BlinkCmpKindProperty', C.snow_0, '', { italic = true })
    hl('BlinkCmpKindUnit', C.frost_2, '', { italic = true })
    hl('BlinkCmpKindValue', C.frost_2, '', { italic = true })
    hl('BlinkCmpKindEnum', C.frost_0_secondary, '', { bold = true, italic = true })
    hl('BlinkCmpKindKeyword', C.frost_2, '', { italic = true })
    hl('BlinkCmpKindSnippet', C.aurora_purple, '', { italic = true })
    hl('BlinkCmpKindColor', C.aurora_purple, '', { italic = true })
    hl('BlinkCmpKindFile', C.aurora_orange, '', { italic = true })
    hl('BlinkCmpKindReference', C.snow_0, '', { italic = true })
    hl('BlinkCmpKindFolder', C.frost_0_secondary, '', { italic = true })
    hl('BlinkCmpKindEnumMember', C.snow_0, '', { bold = true, italic = true })
    hl('BlinkCmpKindConstant', C.snow_0, '', { bold = true, italic = true })
    hl('BlinkCmpKindStruct', C.frost_0_secondary, '', { italic = true })
    hl('BlinkCmpKindEvent', C.aurora_purple, '', { italic = true })
    hl('BlinkCmpKindOperator', C.frost_2, '', { italic = true })
    hl('BlinkCmpKindTypeParameter', C.frost_0_secondary, '', { italic = true })
end

return M
