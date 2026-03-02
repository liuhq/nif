local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
    single_file_support = true,
    capabilities = capabilities,
    settings = {
        json = {
            schemas = {
                {
                    fileMatch = { 'package.json' },
                    url = 'https://json.schemastore.org/package.json',
                },
                {
                    fileMatch = { 'tsconfig*.json' },
                    url = 'https://json.schemastore.org/tsconfig.json',
                },
                {
                    fileMatch = {
                        '.prettierrc',
                        '.prettierrc.json',
                        'prettier.config.json',
                    },
                    url = 'https://json.schemastore.org/prettierrc.json',
                },
                {
                    fileMatch = { '.eslintrc', '.eslintrc.json' },
                    url = 'https://json.schemastore.org/eslintrc.json',
                },
                {
                    fileMatch = {
                        'dprint.json',
                        'dprint.jsonc',
                        '.dprint.json',
                        '.dprint.jsonc',
                    },
                    url = 'https://dprint.dev/schemas/v0.json',
                },
            },
        },
    },
}



--- note: yamlls settings
-- yamlls = {
--     settings = {
--         yaml = {
--             -- Schemas https://www.schemastore.org
--             schemas = {
--                 ['http://json.schemastore.org/gitlab-ci.json'] = { '.gitlab-ci.yml' },
--                 ['https://json.schemastore.org/bamboo-spec.json'] = {
--                     'bamboo-specs/*.{yml,yaml}',
--                 },
--                 ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = {
--                     'docker-compose*.{yml,yaml}',
--                 },
--                 ['http://json.schemastore.org/github-workflow.json'] = '.github/workflows/*.{yml,yaml}',
--                 ['http://json.schemastore.org/github-action.json'] = '.github/action.{yml,yaml}',
--                 ['http://json.schemastore.org/prettierrc.json'] = '.prettierrc.{yml,yaml}',
--                 ['http://json.schemastore.org/stylelintrc.json'] = '.stylelintrc.{yml,yaml}',
--                 ['http://json.schemastore.org/circleciconfig'] = '.circleci/**/*.{yml,yaml}',
--             },
--         },
--     },
-- },
