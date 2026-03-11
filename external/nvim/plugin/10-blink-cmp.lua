require('blink.cmp').setup({
    completion = {
        menu = {
            ---@type blink.cmp.Draw
            draw = {
                columns = { { 'label', 'label_description', gap = 1 }, { 'kind', 'kind_icon', gap = 1 } },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 50,
        },

    },
    signature = {
        enabled = false,
    },
    keymap = {
        preset = 'none',
        ['<C-o>'] = { 'hide', 'show' },
        ['<C-l>'] = { 'select_and_accept', 'fallback' },
        ['<C-h>'] = { 'cancel', 'fallback' },
        ['<C-j>'] = { 'select_next', 'scroll_signature_down', 'snippet_forward', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'scroll_signature_up', 'snippet_backward', 'fallback' },
        ['<tab>'] = { 'hide_documentation', 'show_documentation', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        -- ['<C-s>'] = { 'hide_signature', 'show_signature' },
    },
    cmdline = {
        keymap = { preset = 'inherit' },
        completion = {
            menu = {
                auto_show = true,
            },
        },
    },
})
