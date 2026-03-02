local ConfigUtil = {}
_G.ConfigUtil = ConfigUtil

ConfigUtil.icons = {
    dap = {
        Stopped = '󰁕 ',
        Breakpoint = ' ',
        BreakpointCondition = ' ',
        LogPoint = ' ',
    },
    diagnostics = {
        Sign = '▪',
        Error = '',
        Warn = '',
        Info = '',
        Hint = '',
    },
    git = {
        added = '󰐕',
        changed = '󰧞',
        removed = '󰍴',
    },
    file_status = {
        modified = '',
        readonly = '󰌾',
        unnamed = '󰜥',
        newfile = '󰈔',
    },
}

---Get Mason Packages Command Path from bin
---@param target string command name
---@return string - command path
ConfigUtil.get_cmd_path = function (target)
    local root = vim.fn.stdpath('data') .. '/mason/bin/'
    return root .. target
end
