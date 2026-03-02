local icons = ConfigUtil.icons

_G.stl_comp = {}

local modehl = {
    ['n'] = 'StatusLineModeNormal',
    ['no'] = 'StatusLineModeNormal',
    ['i'] = 'StatusLineModeInsert',
    ['ic'] = 'StatusLineModeInsert',
    ['t'] = 'StatusLineModeInsert',
    ['v'] = 'StatusLineModeVisual',
    ['V'] = 'StatusLineModeVisual',
    [''] = 'StatusLineModeVisual',
    ['R'] = 'StatusLineModeReplace',
    ['Rv'] = 'StatusLineModeReplace',
    ['s'] = 'StatusLineModeDefault',
    ['S'] = 'StatusLineModeDefault',
    [''] = 'StatusLineModeDefault',
    ['c'] = 'StatusLineModeCommand',
    ['cv'] = 'StatusLineModeCommand',
    ['ce'] = 'StatusLineModeCommand',
    ['r'] = 'StatusLineModeReplace',
    ['rm'] = 'StatusLineModeReplace',
    ['r?'] = 'StatusLineModeReplace',
    ['!'] = 'StatusLineModeDefault',
}

-- Mode Color Change: start
_G.stl_comp.mode = function ()
    local mode = vim.api.nvim_get_mode().mode
    if modehl[mode] then
        return '%(%#' .. modehl[mode] .. '# ┃ %{v:lua.string.upper(mode(1))} %*%)'
    else
        return '%(%#StatusLineModeDefault# ┃ %{v:lua.string.upper(mode(1))} %*%)'
    end
end
-- Mode Color Change: end

-- Search Count: start
_G.stl_comp.search_count = function ()
    if vim.v.hlsearch == 1 then
        -- local count = vim.fn.searchcount({ recompute = true })
        local ok, count = pcall(vim.fn.searchcount, { recompute = true })
        if not ok or not count or not count.total or count.total == 0 then
            return ''
        end
        --- buggy, `%{%v:lua.stl_comp.search_count()%}` is not effect. it's so weird
        -- return '%(%#StatusLineSecondary#  At ' .. count.current .. ' / ' .. count.total .. '  %*%)'
        return '  At ' .. count.current .. ' / ' .. count.total .. '  '
    end
    return ''
end
-- Search Count: end

-- LSP: start
_G.stl_comp.lsp = function ()
    local diag = {}
    local count = {}

    for level = 1, 4 do
        count[level] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    if count[vim.diagnostic.severity.ERROR] ~= 0 then
        table.insert(diag, '%#StatusLineDiagError#'
            .. icons.diagnostics.Error
            .. ' '
            .. count[vim.diagnostic.severity.ERROR]
            .. '%*'
        )
    end
    if count[vim.diagnostic.severity.WARN] ~= 0 then
        table.insert(diag, '%#StatusLineDiagWarn#'
            .. icons.diagnostics.Warn
            .. ' '
            .. count[vim.diagnostic.severity.WARN]
            .. '%*'
        )
    end
    if count[vim.diagnostic.severity.INFO] ~= 0 then
        table.insert(diag, '%#StatusLineDiagInfo#'
            .. icons.diagnostics.Info
            .. ' '
            .. count[vim.diagnostic.severity.INFO]
            .. '%*'
        )
    end
    if count[vim.diagnostic.severity.HINT] ~= 0 then
        table.insert(diag, '%#StatusLineDiagHint#'
            .. icons.diagnostics.Hint
            .. ' '
            .. count[vim.diagnostic.severity.HINT]
            .. '%*'
        )
    end

    return ' ' .. table.concat(diag, ' ') .. ' '
end
-- LSP: end


-- Filename and Filepath: start
_G.stl_comp.filepath = function ()
    local fpath = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.:h')
    if fpath == '' or fpath == '.' then
        return ' '
    end
    ---@diagnostic disable-next-line: undefined-field
    local slash = vim.uv.os_uname().sysname == 'Windows_NT' and '\\' or '/'

    return string.format(' %%<%s' .. slash, fpath)
end

_G.stl_comp.filename = function ()
    local fname = vim.fn.expand('%:t')
    if fname == '' then
        return ''
    end
    return fname
end
-- Filename and Filepath: end


-- Filestatus: start
_G.stl_comp.file_readonly = function ()
    return vim.bo.readonly and icons.file_status.readonly or ''
end

_G.stl_comp.file_modified = function ()
    return vim.bo.modified and icons.file_status.modified or ''
end
-- Filestatus: end


-- File Pos: start
_G.stl_comp.filepos = function ()
    return '%(%#StatusLineSecondary# %7(%c:%l%) - %-5(%p%%%) %*%)'
end
-- File Pos: end

-- File Meta: start
_G.stl_comp.filemeta = function ()
    local mode = vim.api.nvim_get_mode().mode
    if modehl[mode] then
        return '%(%#' .. modehl[mode] .. '#%( %Y /%)%( %{toupper(&fileencoding)} %)%(/ %{toupper(&fileformat)} %)┃ %*%)'
    else
        return '%(%#StatusLineModeDefault#%( %Y /%)%( %{toupper(&fileencoding)} %)%(/ %{toupper(&fileformat)} %)┃ %*%)'
    end
end
-- File Meta: end

vim.opt.statusline = table.concat({
    '%#StatusLine#',

    -- mode
    '%{%v:lua.stl_comp.mode()%}',
    -- search count - buggy, `%{%v:lua.stl_comp.search_count()%}` is not effect here. it's so weird
    '%(%#StatusLineSecondary#',
    '%{v:lua.stl_comp.search_count()}',
    '%*%)',
    -- lsp
    '%{%v:lua.stl_comp.lsp()%}',

    ----------------------------------------
    '%=',
    ----------------------------------------

    -- file
    '%(',
    '%{%v:lua.stl_comp.filepath()%}',
    '%{%v:lua.stl_comp.filename()%}',
    -- file flags
    '%( : ',
    '%#StatusLineFlags#',
    '%{%v:lua.stl_comp.file_readonly()%}',
    '%{%v:lua.stl_comp.file_modified()%}',
    '%*',
    '%)',
    -- gitsigns
    ' %{%get(b:, "gitsigns_status", "")%}',
    '%)',

    ----------------------------------------
    '%=',
    ----------------------------------------

    -- file positions
    '%{%v:lua.stl_comp.filepos()%}',
    -- meta
    '%{%v:lua.stl_comp.filemeta()%}',
})
