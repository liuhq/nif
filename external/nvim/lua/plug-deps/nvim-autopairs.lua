local npairs = require('nvim-autopairs')
local npairs_rule = require('nvim-autopairs.rule')
local npairs_cond = require('nvim-autopairs.conds')

npairs.setup({
    disable_filetype = { 'FZF' },
    ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
    enable_check_bracket_line = false,
    check_ts = false,
})

-- remove add single quote on filetype scheme, lisp and rust lifetime annotations
npairs.get_rules("'")[1].not_filetypes = { 'scheme', 'lisp', 'rust', 'nix' }
npairs.get_rules("'")[1]:with_pair(npairs_cond.not_after_text('['))

-- rust closures ||
npairs.add_rule(npairs_rule('|', '|', { 'rust' }):with_pair(npairs_cond.before_text('(')))
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
