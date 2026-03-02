local M = {}

local C = require('nordust.colors')
local hl = require('nordust.utils').hl

M.get = function ()
    hl('@variable.member.private.javascript', '', '', { italic = true })
    hl('@variable.member.private.typescript', '', '', { italic = true })
    hl('@variable.member.private.tsx', { link = '@variable.member.private.typescript' })

    hl('@markup.heading.javascript', '', '')
    hl('@markup.heading.1.javascript', '', '')
    hl('@markup.heading.2.javascript', '', '')
    hl('@markup.heading.3.javascript', '', '')
    hl('@markup.heading.3.javascript', '', '')
    hl('@markup.heading.4.javascript', '', '')

    hl('@markup.quote.javascript', '', '')

    hl('@markup.link.javascript', '', '')
    hl('@markup.link.label.javascript', '', '')
    hl('@markup.link.url.javascript', '', '')

    hl('@markup.raw.javascript', '', '')
    hl('@markup.raw.block.javascript', '', '')

    hl('@markup.list.javascript', '', '')
    hl('@markup.list.checked.javascript', '', '')

    hl('@markup.heading.tsx', '', '')
    hl('@markup.heading.1.tsx', '', '')
    hl('@markup.heading.2.tsx', '', '')
    hl('@markup.heading.3.tsx', '', '')
    hl('@markup.heading.3.tsx', '', '')
    hl('@markup.heading.4.tsx', '', '')

    hl('@markup.quote.tsx', '', '')

    hl('@markup.link.tsx', '', '')
    hl('@markup.link.label.tsx', '', '')
    hl('@markup.link.url.tsx', '', '')

    hl('@markup.raw.tsx', '', '')
    hl('@markup.raw.block.tsx', '', '')

    hl('@markup.list.tsx', '', '')
    hl('@markup.list.checked.tsx', '', '')
end

return M
