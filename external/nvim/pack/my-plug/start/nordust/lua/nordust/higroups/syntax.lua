local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    --- Alias ---
    hl('Deprecated', C.night_3_bright, '', { strikethrough = true })
    hl('ElevatedKeyword', C.frost_2, '', { italic = true, bold = true })
    hl('Punctuation', C.frost_2, '')

    --- syntax ---
    hl('Comment', C.night_3_bright, '')

    hl('Constant', C.snow_0, '', { bold = true })
    hl('String', C.aurora_green, '')
    hl('Character', C.aurora_green, '')
    hl('Number', C.aurora_purple, '')
    hl('Boolean', C.frost_2, '')
    hl('Float', C.aurora_purple, '')

    hl('Identifier', C.snow_0, '')
    hl('Function', C.frost_1_primary, '')

    hl('Statement', C.frost_1_primary, '')
    hl('Conditional', C.frost_2, '', { italic = true })
    hl('Repeat', C.frost_2, '', { italic = true })
    hl('Label', C.frost_2, '', { bold = true })
    hl('Operator', C.frost_2, '')
    hl('Keyword', C.frost_2, '', { italic = true })
    hl('Exception', C.frost_2, '', { italic = true, bold = true })

    hl('PreProc', C.frost_3, '')
    hl('Include', C.frost_3, '')
    hl('Define', C.frost_3, '')
    hl('Macro', { link = 'Define' })
    hl('PreCondit', C.frost_3, '', { bold = true })

    hl('Type', C.frost_0_secondary, '')
    hl('StorageClass', C.frost_0_secondary, '')
    hl('Structure', C.frost_0_secondary, '')
    hl('Typedef', C.frost_0_secondary, '')

    hl('Special', C.snow_0, '', { bold = true })
    hl('SpecialChar', C.aurora_yellow, '')
    hl('Tag', C.frost_2, '')
    hl('Delimiter', C.snow_2, '')
    hl('SpecialComment', C.frost_3, '', { bold = true, italic = true })
    hl('Debug', { link = 'Special' })

    hl('Underlined', '', '', { underline = true })

    hl('Ignore', C.snow_0)

    hl('Error', C.snow_2, C.aurora_red)

    hl('Todo', C.aurora_yellow, '', { bold = true })

    --- Diff ---
    hl('Added', C.aurora_green, '')
    hl('Changed', C.aurora_yellow, '')
    hl('Removed', C.aurora_red, '')
    hl('DiffAdd', { link = 'Added' })
    hl('DiffChange', { link = 'Changed' })
    hl('DiffDelete', { link = 'Removed' })
    hl('DiffText', C.frost_2, '')
    hl('diffOldFile', C.frost_2, '')
    hl('diffNewFile', C.frost_1_primary, '')

    --- css ---
    hl('cssVendor', { link = 'Keyword' })
    hl('cssDeprecated', { link = 'DiagnosticDeprecated' })
    hl('cssAttrComma', { link = 'Punctuation' })
    hl('cssAttr', { link = 'Keyword' })
    hl('cssBraces', { link = 'Delimiter' })
    hl('cssUnitDecorators', C.frost_2, '')
end

return M
