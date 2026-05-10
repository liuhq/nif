local icons = ConfigUtil.icons

local bufferline = require('bufferline')
bufferline.setup({
    options = {
        mode = 'buffers',
        themable = true,
        numbers = function (opts)
            ---@diagnostic disable-next-line: undefined-field
            return opts.raise(opts.id)
        end,
        indicator = {
            style = 'underline',
        },
        modified_icon = icons.file_status.modified,
        left_trunc_marker = '',
        right_trunc_marker = '',
        name_formatter = function (buf)
            ---@diagnostic disable-next-line: undefined-field
            if vim.bo[buf.bufnr].filetype == 'qf' then
                return 'Quickfix List'
            end
            ---@diagnostic disable-next-line: undefined-field
            return buf.name
        end,
        diagnostics = 'nvim_lsp',
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        separator_style = 'thin',
        always_show_bufferline = false,
        style_preset = {
            bufferline.style_preset.no_bold,
            bufferline.style_preset.no_italic,
        },
    },
    highlights = require('nordust.higroups._bufferline').get(),
    -- highlights = require('catppuccin.special.bufferline').get_theme(),
})
