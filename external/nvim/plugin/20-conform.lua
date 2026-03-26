local js_fmt_config = { 'prettier', 'dprint', 'deno_fmt', stop_after_first = true }

require('conform').setup({
    formatters_by_ft = {
        sh = { 'shfmt' },
        zsh = { 'shfmt' },
        rust = { 'rustfmt' },
        javascript = js_fmt_config,
        javascriptreact = js_fmt_config,
        typescript = js_fmt_config,
        typescriptreact = js_fmt_config,
        html = js_fmt_config,
        css = js_fmt_config,
        json = js_fmt_config,
        jsonc = js_fmt_config,
        yaml = { 'dprint', 'yamlfmt', stop_after_first = true },
        markdown = js_fmt_config,
    },
    default_format_opts = {
        lsp_format = 'fallback',
    },
    formatters = {
        shfmt = { prepend_args = { '-i', '2' } },
        injected = { options = { ignore_errors = true } },
        prettier = {
            condition = function (_, ctx)
                return vim.fs.find(
                    {
                        '.prettierrc',
                        '.prettierrc.json',
                        '.prettierrc.yml',
                        '.prettierrc.yaml',
                        '.prettierrc.json5',
                        '.prettierrc.js',
                        'prettier.config.js',
                        '.prettierrc.ts',
                        'prettier.config.ts',
                        '.prettierrc.mjs',
                        'prettier.config.mjs',
                        '.prettierrc.mts',
                        'prettier.config.mts',
                        '.prettierrc.cjs',
                        'prettier.config.cjs',
                        '.prettierrc.cts',
                        'prettier.config.cts',
                        '.prettierrc.toml',
                    },
                    { path = ctx.filename, upward = true, type = 'file' })[1] ~= nil
            end,
        },
        dprint = {
            condition = function (_, ctx)
                return vim.fs.find(
                    {
                        'dprint.json',
                        '.dprint.json',
                        'dprint.jsonc',
                        '.dprint.jsonc',
                    },
                    { path = ctx.filename, upward = true, type = 'file' })[1] ~= nil
            end,
        },
        deno_fmt = {
            append_args = { '--indent-width', '2', '--no-semicolons', '--single-quote' },
        },
    },
})

vim.o.formatexpr = 'v:lua.require("conform").formatexpr()'

vim.keymap.set({ 'n', 'v' }, 'g=', function ()
    require('conform').format({ async = true }, function (err)
        if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), 'v') then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
            end
        end
    end)
end, { desc = 'Format' })
