local M = {}

M.is_table = function (value)
    return type(value) == 'table'
end

M.is_string = function (value)
    return type(value) == 'string'
end

---@param group string highlight group name
---@param fg_or_link string|{link: (string|integer)} foreground color or link
---@param bg? string background color
---@param style? vim.api.keyset.highlight highlight style
M.hl = function (group, fg_or_link, bg, style)
    local color = {}

    if M.is_table(fg_or_link) then
        ---@cast fg_or_link {link: (string|integer)}
        color = fg_or_link
    else
        if M.is_string(fg_or_link) and fg_or_link ~= '' then
            ---@cast fg_or_link string
            color.fg = fg_or_link
        end

        if bg and bg ~= '' then
            color.bg = bg
        end
    end

    local _style = vim.tbl_deep_extend('keep', color, style or {})

    vim.api.nvim_set_hl(0, group, _style)
end

---Get module files in target directory
---@param target string target directory path
---@return table modules name
M.get_modules = function (target)
    local files = {}

    ---@diagnostic disable-next-line: undefined-field
    if (not vim.uv.fs_stat(target)) or vim.uv.fs_stat(target).type ~= 'directory' then
        print('Invalid directory: ' .. target)
        return files
    end

    for name, type in vim.fs.dir(target) do
        if type == 'file' or type == 'directory' then
            local fname = name:gsub('%.lua$', '')
            if fname == 'init' then
                goto continue
            end
            table.insert(files, fname)
        end
        ::continue::
    end

    return files
end

return M
