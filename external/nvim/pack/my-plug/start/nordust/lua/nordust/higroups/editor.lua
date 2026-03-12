local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    vim.g.terminal_color_0 = C.night_1
    vim.g.terminal_color_1 = C.aurora_red
    vim.g.terminal_color_2 = C.aurora_green
    vim.g.terminal_color_3 = C.aurora_yellow
    vim.g.terminal_color_4 = C.frost_2
    vim.g.terminal_color_5 = C.aurora_purple
    vim.g.terminal_color_6 = C.frost_1_primary
    vim.g.terminal_color_7 = C.snow_1
    vim.g.terminal_color_8 = C.night_3
    vim.g.terminal_color_9 = C.aurora_red
    vim.g.terminal_color_10 = C.aurora_green
    vim.g.terminal_color_11 = C.aurora_yellow
    vim.g.terminal_color_12 = C.frost_2
    vim.g.terminal_color_13 = C.aurora_purple
    vim.g.terminal_color_14 = C.frost_0_secondary
    vim.g.terminal_color_15 = C.snow_2

    --- syntax.txt ---
    hl('ColorColumn', '', C.night_0)
    hl('Conceal', '', '')
    hl('CurSearch', C.base, C.aurora_yellow)
    hl('Cursor', C.base, C.snow_0)
    hl('lCursor', C.night_0, C.snow_0)
    hl('CursorColumn', '', C.night_0)
    hl('CursorLine', '', C.night_0)
    hl('Directory', C.frost_1_primary, '')
    hl('EndOfBuffer', C.night_0, '')
    hl('ErrorMsg', C.snow_2, C.aurora_red)
    hl('WinSeparator', C.night_3, C.base)
    hl('Folded', C.frost_3, C.night_0, { bold = true })
    hl('FoldColumn', C.frost_3, C.base)
    hl('SignColumn', C.night_2, C.base)
    hl('IncSearch', C.snow_2, C.frost_3, { underline = true })
    hl('Substitute', C.base, C.frost_1_primary)
    hl('LineNr', C.night_3_bright, '')
    hl('CursorLineNr', C.base, C.frost_1_primary)
    hl('MatchParen', C.frost_1_primary, C.night_3)
    hl('ModeMsg', C.snow_0, '')
    hl('MoreMsg', C.frost_1_primary, '')
    hl('NonText', C.night_1, '')
    hl('Normal', C.snow_0, C.base)
    hl('NormalFloat', C.snow_0, C.night_1)
    hl('NormalNC', { link = 'Normal' })
    hl('Pmenu', { link = 'NormalFloat' })
    hl('PmenuSel', '', C.night_3)
    hl('PmenuExtraSel', '', C.night_3)
    hl('PmenuSbar', C.night_3_bright, C.night_0)
    hl('PmenuThumb', C.frost_1_primary, C.night_3_bright)
    hl('PmenuMatch', C.snow_2, '', { bold = true })
    hl('PmenuMatchSel', '', '', { bold = true })
    hl('Question', C.snow_0, '')
    hl('QuickFixLine', C.aurora_yellow, '')
    hl('Search', C.base, C.frost_1_primary)
    hl('SpecialKey', C.night_2, '')
    hl('SpellBad', C.aurora_red, '', { undercurl = true, sp = C.aurora_red })
    hl('SpellCap', C.aurora_yellow, '', { undercurl = true, sp = C.aurora_yellow })
    hl('SpellLocal', C.snow_1, '', { undercurl = true, sp = C.snow_1 })
    hl('SpellRare', C.snow_2, '', { undercurl = true, sp = C.snow_2 })
    hl('StatusLine', C.frost_1_primary, C.night_0)
    hl('StatusLineNC', { link = 'StatusLine' })
    hl('StatusLineTerm', { link = 'StatusLine' })
    hl('StatusLineTermNC', { link = 'StatusLine' })
    hl('TabLine', C.night_3_bright, C.night_0)
    hl('TabLineFill', C.night_3_bright, C.night_0)
    hl('TabLineSel', C.frost_1_primary, C.night_3)
    hl('Title', C.snow_0, '')
    hl('Visual', '', C.night_1)
    hl('VisualNOS', '', C.night_1)
    hl('WarningMsg', C.base, C.aurora_yellow)
    hl('Whitespace', '', C.night_1)
    hl('WildMenu', { link = 'PmenuSel' })
    hl('WinBar', C.night_3_bright, C.night_0)
    hl('WinBarNC', { link = 'WinBar' })

    --- options.txt:3081 ---
    hl('iCursor', C.snow_0, C.night_3_bright)

    --- diagnostic.txt ---
    hl('DiagnosticError', C.aurora_red, '')
    hl('DiagnosticWarn', C.aurora_yellow, '')
    hl('DiagnosticInfo', C.frost_1_primary, '')
    hl('DiagnosticHint', C.frost_3, '')
    hl('DiagnosticOk', C.aurora_green, '')
    hl('DiagnosticVirtualTextError', C.aurora_red, C.night_0)
    hl('DiagnosticVirtualTextWarn', C.aurora_yellow, C.night_0)
    hl('DiagnosticVirtualTextInfo', C.frost_1_primary, C.night_0)
    hl('DiagnosticVirtualTextHint', C.frost_3, C.night_0)
    hl('DiagnosticVirtualTextOk', C.aurora_green, C.night_0)
    hl('DiagnosticUnderlineError', C.aurora_red, '', { undercurl = true })
    hl('DiagnosticUnderlineWarn', C.aurora_yellow, '', { undercurl = true })
    hl('DiagnosticUnderlineInfo', C.frost_1_primary, '', { undercurl = true })
    hl('DiagnosticUnderlineHint', C.frost_3, '', { undercurl = true })
    hl('DiagnosticUnderlineOk', C.aurora_green, '', { undercurl = true })
    hl('DiagnosticDeprecated', { link = 'Deprecated' })
end

return M
