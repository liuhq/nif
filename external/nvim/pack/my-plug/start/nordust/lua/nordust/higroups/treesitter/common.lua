local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function (_)
    --- Identifiers
    hl('@variable', { link = 'Identifier' })
    hl('@variable.builtin', { link = 'Special' })
    hl('@variable.parameter', { link = 'Identifier' })
    hl('@variable.parameter.builtin', { link = 'Special' })
    hl('@variable.member', { link = 'Identifier' })

    hl('@constant', { link = 'Constant' })
    hl('@constant.builtin', { link = 'Constant' })
    hl('@constant.macro', C.frost_3, '', { bold = true, underline = true })

    hl('@module', { link = 'Structure' })
    hl('@module.builtin', { link = 'Structure' })
    hl('@label', { link = 'Label' })

    hl('@string', { link = 'String' })
    hl('@string.documentation', C.aurora_green, '', { bold = true })
    hl('@string.regexp', { link = 'SpecialChar' })
    hl('@string.escape', { link = 'SpecialChar' })
    hl('@string.special', { link = 'SpecialChar' })
    hl('@string.special.symbol', { link = 'SpecialChar' })
    hl('@string.special.path', C.aurora_orange, '', { underdotted = true })
    hl('@string.special.url', C.aurora_orange, '', { underline = true })

    hl('@character', { link = 'Character' })
    hl('@character.special', { link = 'SpecialChar' })

    hl('@boolean', { link = 'Boolean' })
    hl('@number', { link = 'Number' })
    hl('@number.float', { link = 'Float' })

    hl('@type', { link = 'Type' })
    hl('@type.builtin', { link = 'Type' })
    hl('@type.definition', { link = 'Define' })

    hl('@attribute', C.aurora_orange, '')
    hl('@attribute.builtin', { link = '@attribute' })
    hl('@property', { link = 'Identifier' })

    hl('@function', C.frost_0_secondary, '')
    hl('@function.builtin', C.frost_0_secondary, '')
    hl('@function.call', C.frost_1_primary, '')
    hl('@function.macro', { link = 'Macro' })

    hl('@function.method', { link = '@function' })
    hl('@function.method.call', C.frost_1_primary, '', { bold = true })

    hl('@constructor', { link = '@function.method.call' })
    hl('@operator', { link = 'Operator' })

    hl('@keyword', { link = 'Keyword' })
    hl('@keyword.coroutine', { link = 'ElevatedKeyword' })
    hl('@keyword.function', { link = 'Keyword' })
    hl('@keyword.operator', { link = 'Operator' })
    hl('@keyword.import', { link = 'ElevatedKeyword' })
    hl('@keyword.type', { link = 'Keyword' })
    hl('@keyword.modifier', { link = 'Keyword' })
    hl('@keyword.repeat', { link = 'Keyword' })
    hl('@keyword.return', { link = 'ElevatedKeyword' })
    hl('@keyword.debug', { link = 'Debug' })
    hl('@keyword.exception', { link = 'Exception' })

    hl('@keyword.conditional', { link = 'Keyword' })
    hl('@keyword.conditional.ternary', { link = 'Operator' })

    hl('@keyword.directive', { link = 'Operator' })
    hl('@keyword.directive.define', { link = 'Operator' })

    hl('@punctuation.delimiter', { link = 'Punctuation' })
    hl('@punctuation.bracket', { link = 'Delimiter' })
    hl('@punctuation.special', { link = 'Special' })

    hl('@comment', { link = 'Comment' })
    hl('@comment.documentation', { link = 'SpecialComment' })

    hl('@comment.error', C.aurora_red, '', { bold = true })
    hl('@comment.warning', C.aurora_yellow, '', { bold = true })
    hl('@comment.todo', { link = 'Todo' })
    hl('@comment.note', { link = 'DiagnosticInfo' })

    hl('@markup.heading', C.snow_1, '')
    hl('@markup.heading.1', C.frost_1_primary, '', { bold = true })
    hl('@markup.heading.2', C.frost_0_secondary, '', { bold = true })
    hl('@markup.heading.3', C.frost_2, '', { bold = true })
    hl('@markup.heading.3', '', '', { bold = true })
    hl('@markup.heading.4', '', '', { underdashed = true })

    hl('@markup.quote', { link = 'Comment' })

    hl('@markup.link', { link = 'Delimiter' })
    hl('@markup.link.label', C.aurora_green, '', { underline = true })
    hl('@markup.link.url', { link = '@string.special.url' })

    hl('@markup.raw', C.snow_0, C.night_1)
    hl('@markup.raw.block', C.snow_0, '')

    hl('@markup.list', C.aurora_purple, '', { bold = true })
    hl('@markup.list.checked', C.night_3_bright, '', { bold = true })

    hl('@tag', { link = 'Tag' })
    hl('@tag.builtin', { link = 'Tag' })
    hl('@tag.attribute', { link = 'Identifier' })
    hl('@tag.delimiter', { link = 'Delimiter' })
end

return M
