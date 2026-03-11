local npairs = require('nvim-autopairs')
local npairs_rule = require('nvim-autopairs.rule')
local npairs_cond = require('nvim-autopairs.conds')
local npairs_utils = require('nvim-autopairs.utils')
local npairs_log = require('nvim-autopairs._log')

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

-- {{{ https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#auto-addspace-on-
npairs.add_rule(
    npairs_rule('=', '', { '-sh', '-nix' })
    :with_pair(npairs_cond.not_inside_quote())
    :with_pair(function (opts)
        local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
        if last_char:match('[%w%=%s]') then
            return true
        end
        return false
    end)
    :replace_endpair(function (opts)
        local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
        local next_char = opts.line:sub(opts.col, opts.col)
        next_char = next_char == ' ' and '' or ' '
        if prev_2char:match('%w$') then
            return '<bs> =' .. next_char
        end
        if prev_2char:match('%=$') then
            return next_char
        end
        if prev_2char:match('=') then
            return '<bs><bs>=' .. next_char
        end
        return ''
    end)
    :set_end_pair_length(0)
    :with_move(npairs_cond.none())
    :with_del(npairs_cond.none())
)
-- }}}

-- {{{ https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#when-typing-space-equals-for-assignment-in-nix-add-the-final-semicolon-to-the-line
-- Note that when the cursor is at the end of a comment line,
-- treesitter thinks we are in attrset_expression
-- because the cursor is "after" the comment, even though it is on the same line.
local is_not_ts_node_comment_one_back = function ()
    return function (info)
        npairs_log.debug('not_in_ts_node_comment_one_back')

        local p = vim.api.nvim_win_get_cursor(0)
        -- Subtract one to account for 1-based row indexing in nvim_win_get_cursor
        -- Also subtract one from the position of the column to see if we are at the end of a comment.
        local pos_adjusted = { p[1] - 1, p[2] - 1 }

        vim.treesitter.get_parser():parse()
        local target = vim.treesitter.get_node({ pos = pos_adjusted, ignore_injections = false })
        npairs_log.debug(target:type())
        if target ~= nil and npairs_utils.is_in_table({ 'comment' }, target:type()) then
            return false
        end

        local rest_of_line = info.line:sub(info.col)
        return rest_of_line:match('^%s*$') ~= nil
    end
end

npairs.add_rule(
    npairs_rule('=', ';', 'nix')
    :with_pair(is_not_ts_node_comment_one_back())
    :replace_endpair(function (opts)
        if opts.line:match(';$') then
            return ''
        end

        local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
        if prev_2char:match('%w$') then
            return '<bs> = ' .. opts.rule.end_pair
        end

        local spaces = opts.line:match('=(%s*)$')
        if #spaces > 0 then
            return string.rep('<bs>', #spaces) .. opts.rule.end_pair
        elseif #spaces == 0 then
            return '<bs> ' .. opts.rule.end_pair
        end

        return ' ;'
    end)
    :set_end_pair_length(1)
)
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
