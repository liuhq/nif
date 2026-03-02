local M = {}

local C = require('nordust.colors')

M.get = function ()
    local active_fg = C.frost_1_primary
    local active_bg = C.night_1
    local inactive_fg = C.night_3_bright
    local inactive_bg = C.base

    local highlight = {
        -- buffers
        background = { bg = inactive_bg },
        buffer_visible = { fg = inactive_fg, bg = inactive_bg },
        buffer_selected = { fg = active_fg, bg = active_bg, bold = true }, -- current
        -- Duplicate
        duplicate_selected = { fg = active_fg, bg = active_bg, bold = true, italic = true },
        duplicate_visible = { fg = inactive_fg, bg = inactive_bg, italic = true },
        duplicate = { fg = inactive_fg, bg = inactive_bg, italic = true },
        -- tabs
        tab = { fg = inactive_fg, bg = inactive_bg },
        tab_selected = { fg = C.frost_0_secondary, bg = active_bg, bold = true },
        tab_separator = { fg = C.snow_0, bg = inactive_bg },
        tab_separator_selected = { fg = C.snow_1, bg = active_bg },

        tab_close = { fg = C.aurora_red, bg = inactive_bg },
        indicator_visible = { fg = C.aurora_orange, bg = inactive_bg },
        indicator_selected = { fg = C.aurora_orange, bg = active_bg },
        -- separators
        separator = { fg = C.snow_0, bg = inactive_bg },
        separator_visible = { fg = C.snow_0, bg = inactive_bg },
        separator_selected = { fg = C.snow_0, bg = active_bg },
        offset_separator = { fg = C.snow_0, bg = active_bg },
        -- close buttons
        close_button = { fg = inactive_fg, bg = inactive_bg },
        close_button_visible = { fg = inactive_fg, bg = inactive_bg },
        close_button_selected = { fg = C.aurora_red, bg = active_bg },
        -- Empty fill
        fill = { bg = C.base },
        -- Numbers
        numbers = { fg = inactive_fg, bg = inactive_bg },
        numbers_visible = { fg = inactive_fg, bg = inactive_bg },
        numbers_selected = { fg = active_fg, bg = active_bg },
        -- Errors
        error = { fg = inactive_fg, bg = inactive_bg, sp = C.aurora_red, undercurl = true },
        error_visible = { fg = inactive_fg, bg = inactive_bg, sp = C.aurora_red, undercurl = true },
        error_selected = { fg = active_fg, bg = active_bg, sp = C.aurora_red, undercurl = true },
        error_diagnostic = { fg = inactive_fg, bg = inactive_bg, sp = C.aurora_red, undercurl = true },
        error_diagnostic_visible = { fg = inactive_fg, bg = inactive_bg, sp = C.aurora_red, undercurl = true },
        error_diagnostic_selected = { fg = active_fg, bg = active_bg, sp = C.aurora_red, undercurl = true },
        -- Warnings
        warning = { fg = inactive_fg, bg = inactive_bg, sp = C.aurora_yellow, undercurl = true },
        warning_visible = { fg = inactive_fg, bg = inactive_bg, sp = C.aurora_yellow, undercurl = true },
        warning_selected = { fg = active_fg, bg = active_bg, sp = C.aurora_yellow, undercurl = true },
        warning_diagnostic = { fg = inactive_fg, bg = inactive_bg, sp = C.aurora_yellow, undercurl = true },
        warning_diagnostic_visible = { fg = inactive_fg, bg = inactive_bg, sp = C.aurora_yellow, undercurl = true },
        warning_diagnostic_selected = { fg = active_fg, bg = active_bg, sp = C.aurora_yellow, undercurl = true },
        -- Infos
        info = { fg = inactive_fg, bg = inactive_bg, sp = C.frost_1_primary, underdotted = true },
        info_visible = { fg = inactive_fg, bg = inactive_bg, sp = C.frost_1_primary, underdotted = true },
        info_selected = { fg = active_fg, bg = active_bg, sp = C.frost_1_primary, undercurl = true },
        info_diagnostic = { fg = inactive_fg, bg = inactive_bg, sp = C.frost_1_primary, underdotted = true },
        info_diagnostic_visible = { fg = inactive_fg, bg = inactive_bg, sp = C.frost_1_primary, underdotted = true },
        info_diagnostic_selected = { fg = active_fg, bg = active_bg, sp = C.frost_1_primary, undercurl = true },
        -- Hint
        hint = { fg = inactive_fg, bg = inactive_bg, sp = C.frost_3, underdotted = true },
        hint_visible = { fg = inactive_fg, bg = inactive_bg, sp = C.frost_3, underdotted = true },
        hint_selected = { fg = active_fg, bg = active_bg, sp = C.frost_3, undercurl = true },
        hint_diagnostic = { fg = inactive_fg, bg = inactive_bg, sp = C.frost_3, underdotted = true },
        hint_diagnostic_visible = { fg = inactive_fg, bg = inactive_bg, sp = C.frost_3, underdotted = true },
        hint_diagnostic_selected = { fg = active_fg, bg = active_bg, sp = C.frost_3, undercurl = true },
        -- Diagnostics
        diagnostic = { fg = inactive_fg, bg = inactive_bg },
        diagnostic_visible = { fg = inactive_fg, bg = inactive_bg },
        diagnostic_selected = { fg = active_fg, bg = active_bg },
        -- Modified
        modified = { fg = C.aurora_orange, bg = inactive_bg },
        modified_visible = { fg = C.aurora_orange, bg = inactive_bg },
        modified_selected = { fg = C.aurora_orange, bg = active_bg },

        trunc_marker = { fg = C.snow_0, bg = C.base },
    }
    return highlight
end

return M
