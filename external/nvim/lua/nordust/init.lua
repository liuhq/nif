local M = {}

local get_modules = require('nordust.utils').get_modules

M.setup = function ()
    local higroups = vim.fn.stdpath('config') .. '/lua/nordust/higroups'
    local higroup_files = get_modules(higroups)
    for _, group in ipairs(higroup_files) do
        --- disable a highlight by add a prefix '_' for file name
        if group:sub(1, 1) ~= '_' then
            require('nordust.higroups.' .. group).get()
        end
    end
end

return M
