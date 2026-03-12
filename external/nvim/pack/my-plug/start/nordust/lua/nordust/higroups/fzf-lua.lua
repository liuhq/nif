local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('FzfLuaTitleFlags', C.aurora_yellow, C.night_0)
    hl('FzfLuaHeaderBind', C.frost_1_primary, '')
    hl('FzfLuaHeaderText', C.snow_0, '')
    hl('FzfLuaPathColNr', C.aurora_purple, '')
    hl('FzfLuaPathLineNr', C.aurora_purple, '')
    hl('FzfLuaBufName', C.snow_0, '')
    hl('FzfLuaBufId', C.aurora_purple, '')
    hl('FzfLuaBufNr', C.aurora_purple, '')
    hl('FzfLuaBufFlagCur', C.frost_1_primary, '')
    hl('FzfLuaBufFlagAlt', C.frost_0_secondary, '')
    hl('FzfLuaLivePrompt', C.frost_1_primary, '')
    hl('FzfLuaCmdEx', C.frost_2, '')
    hl('FzfLuaCmdBuf', C.aurora_green, '')
    hl('FzfLuaCmdGlobal', C.snow_0, '')
end

return M
