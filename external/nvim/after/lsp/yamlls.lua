return {
    ---@type lspconfig.settings.yamlls
    settings = {
        yaml = {
            hover = true,
            completion = true,
            editor = { tabSize = 2 },
            format = {
                enable = true,
                bracketSpacing = true,
            },
            schemaStore = {
                enable = false,
                url = '',
            },
            schemas = require('schemastore').yaml.schemas(),
        },
        redhat = {
            telemetry = {
                enabled = false,
            },
        },
    },
}
