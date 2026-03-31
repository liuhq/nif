local npairs = require('nvim-autopairs')
local npairs_rule = require('nvim-autopairs.rule')
local npairs_cond = require('nvim-autopairs.conds')

npairs.setup({
    disable_filetype = { 'FZF' },
    ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
    enable_check_bracket_line = false,
    check_ts = false,
})

-- {{{ https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#add-spaces-between-parentheses
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
    -- Rule for a pair with left-side ' ' and right side ' '
    npairs_rule(' ', ' ')
    -- Pair will only occur if the conditional function returns true
        :with_pair(function (opts)
            -- We are checking if we are inserting a space in (), [], or {}
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({
                brackets[1][1] .. brackets[1][2],
                brackets[2][1] .. brackets[2][2],
                brackets[3][1] .. brackets[3][2],
            }, pair)
        end)
        :with_move(npairs_cond.none())
        :with_cr(npairs_cond.none())
    -- We only want to delete the pair of spaces when the cursor is as such: ( | )
        :with_del(function (opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({
                brackets[1][1] .. '  ' .. brackets[1][2],
                brackets[2][1] .. '  ' .. brackets[2][2],
                brackets[3][1] .. '  ' .. brackets[3][2],
            }, context)
        end),
}
-- For each pair of brackets we will add another rule
for _, bracket in pairs(brackets) do
    npairs.add_rules {
        -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
        npairs_rule(bracket[1] .. ' ', ' ' .. bracket[2])
            :with_pair(npairs_cond.none())
            :with_move(function (opts) return opts.char == bracket[2] end)
            :with_del(npairs_cond.none())
            :use_key(bracket[2])
        -- Removes the trailing whitespace that can occur without this
            :replace_map_cr(function (_) return '<C-c>2xi<CR><C-c>O' end),
    }
end
-- }}}

-- remove add single quote on filetype scheme, lisp and rust lifetime annotations
npairs.get_rules("'")[1].not_filetypes = { 'scheme', 'lisp', 'rust', 'nix' }
npairs.get_rules("'")[1]:with_pair(npairs_cond.not_after_text('['))

-- rust closures ||
npairs.add_rule(
    npairs_rule('|', '|', { 'rust' })
    :with_pair(function (opts)
        local before = opts.line:sub(1, opts.col - 1)
        local after = opts.line:sub(opts.col)

        local before_ok = before:match('[%({=]%s*$') ~= nil
        local after_ok = after:match('^[%s{}%);]*$') ~= nil

        return before_ok and after_ok
    end)
    :with_move(function (opts)
        return opts.char == '|'
    end)
)

npairs.add_rule(
    npairs_rule("'", "'", { 'rust' })
    :with_pair(npairs_cond.not_before_text('<'))
    :with_pair(npairs_cond.not_before_text('&'))
)

-- markdown
npairs.add_rule(npairs_rule('*', '*', { 'markdown' }):with_pair(npairs_cond.not_after_text('**')))
npairs.add_rule(npairs_rule('_', '_', { 'markdown' }):with_pair(npairs_cond.not_after_text('__')))
npairs.add_rule(npairs_rule('~', '~', { 'markdown' }))

-- auto-pair <> for generics
npairs.add_rule(npairs_rule('<', '>', {
    '-scheme',
    '-lisp',
    -- doesn't conflict with nvim-ts-autotag
    '-html',
    '-javascriptreact',
    '-typescriptreact',
}):with_pair(
-- regex will make it so that it will auto-pair on `a<` but not `a <`
-- The `:?:?` part makes it also work on Rust generics like `some_func::<T>()`
    npairs_cond.before_regex('%a+:?:?$', 3)
):with_move(function (opts)
    return opts.char == '>'
end))
