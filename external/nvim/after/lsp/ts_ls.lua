return {
    root_dir = function (bufnr, on_dir)
        local node_markers = {
            'package.json',
            'package-lock.json',
            'tsconfig.json',
            'yarn.lock',
            'pnpm-lock.yaml',
            'bun.lockb',
            'bun.lock',
        }
        local project_root = vim.fs.root(bufnr, node_markers)

        -- exclude deno and resolve monorepo
        local deno_root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' })
        local deno_lock_root = vim.fs.root(bufnr, { 'deno.lock' })
        if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
            -- deno lock is closer than package manager lock, abort
            return
        end
        if deno_root and (not project_root or #deno_root >= #project_root) then
            -- deno config is closer than or equal to package manager lock, abort
            return
        end

        -- project is standard TS, not deno
        if project_root then
            on_dir(project_root)
        end

        -- use deno as default js/ts file lsp, so return nil
    end,
    ---@type lspconfig.settings.ts_ls
    settings = {
        javascript = {
            format = {
                semicolons = 'remove',
            },
            inlayHints = {
                functionLikeReturnTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
            },
            preferGoToSourceDefinition = true,
            preferences = {
                quoteStyle = 'single',
            },
        },
        typescript = {
            format = {
                semicolons = 'remove',
            },
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
            },
            preferGoToSourceDefinition = true,
            preferences = {
                preferTypeOnlyAutoImports = true,
                quoteStyle = 'single',
            },
            tsserver = {
                experimental = {
                    enableProjectDiagnostics = true,
                },
            },
        },
    },
}
