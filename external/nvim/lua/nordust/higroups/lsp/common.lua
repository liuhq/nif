local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('LspReferenceText', '', C.night_1)
    hl('LspReferenceRead', { link = 'LspReferenceText' })
    hl('LspReferenceWrite', { link = 'LspReferenceText' })
    hl('LspReferenceTarget', { link = 'LspReferenceText' })
    hl('LspInlayHint', C.night_3_bright, C.night_0)

    hl('LspCodeLens', C.night_3_bright, '', { underdotted = true })
    hl('LspCodeLensSeparator', { link = 'LspCodeLens' })

    hl('LspSignatureActiveParameter', C.frost_1_primary, '', { underline = true })

    --- Tokens ---
    --- TYPE ---
    hl('@lsp.type.class', { link = '@type' })
    hl('@lsp.type.comment', { link = '@comment' })
    hl('@lsp.type.decorator', C.aurora_orange, '')
    hl('@lsp.type.enum', C.frost_0_secondary, '', { bold = true })
    hl('@lsp.type.enumMember', C.snow_0, '', { bold = true })
    hl('@lsp.type.event', C.aurora_purple, '')
    hl('@lsp.type.function', '', '')
    hl('@lsp.type.interface', { link = '@module' })
    hl('@lsp.type.keyword', { link = '@keyword' })
    hl('@lsp.type.macro', { link = '@function.macro' })
    hl('@lsp.type.method', '', '')
    hl('@lsp.type.modifier', { link = '@keyword.modifier' })
    hl('@lsp.type.namespace', { link = '@module' })
    hl('@lsp.type.number', { link = '@number' })
    hl('@lsp.type.operator', { link = '@operator' })
    hl('@lsp.type.parameter', { link = '@variable.parameter' })
    hl('@lsp.type.property', { link = '@property' })
    hl('@lsp.type.regexp', { link = '@string.regexp' })
    hl('@lsp.type.string', { link = '@string' })
    hl('@lsp.type.struct', { link = '@type' })
    hl('@lsp.type.type', { link = '@type' })
    hl('@lsp.type.typeParameter', { link = '@type' })
    hl('@lsp.type.variable', { link = '@variable' })

    --- MOD ---
    -- @lsp.mod.abstract
    -- @lsp.mod.async
    -- @lsp.mod.declaration
    -- @lsp.mod.defaultLibrary
    -- @lsp.mod.definition
    -- @lsp.mod.deprecated
    -- @lsp.mod.documentation
    -- @lsp.mod.modification
    -- @lsp.mod.readonly
    -- @lsp.mod.static
    hl('@lsp.mod.deprecated', { link = 'Deprecated' })
end

return M
