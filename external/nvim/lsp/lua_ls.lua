return {
    on_init = function (client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                ---@diagnostic disable-next-line: undefined-field
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT',
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                    '?.lua',
                    '?/init.lua',
                },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                -- library = {
                --     vim.env.VIMRUNTIME,
                -- },
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                library = vim.api.nvim_get_runtime_file('', true),
            },
        })
    end,
    settings = {
        format = {
            enable = true,
            defaultConfig = {
                indent_style = 'space',
                indent_size = '4',
                quote_style = 'single',
                call_arg_parentheses = 'keep',
                continuation_indent = '4',
                max_line_length = '120',
                end_of_line = 'lf',
                trailing_table_separator = 'smart',
                space_around_table_field_list = 'true',
                align_call_args = 'false',
                align_function_params = 'false',
                align_continuous_assign_statement = 'false',
                align_continuous_rect_table_field = 'false',
                align_array_table = 'false',
            },
        },
        Lua = {},
    },
}
