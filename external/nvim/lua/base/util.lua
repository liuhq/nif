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
