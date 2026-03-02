return {
    single_file_support = true,
    settings = {
        yaml = {
            hover = true,
            completion = true,
            editor = { tabSize = 2 },
            format = {
                enable = true,
                bracketSpacing = true,
            },
            schemaStore = { enable = true },
            schemas = {
                ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
            },
        },
    },
}
