vim.g.markdown_fenced_languages = {
    'ts=typescript',
}

---@type vim.lsp.Config
return {
    root_dir = function (bufnr, on_dir)
        local deno_markers = { 'deno.lock', 'deno.json', 'deno.jsonc' }
        local root_markers = { deno_markers, { '.git' } }

        local deno_root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' })
        local deno_lock_root = vim.fs.root(bufnr, { 'deno.lock' })
        local project_root = vim.fs.root(bufnr, root_markers)

        -- resolve monorepo
        if (deno_lock_root
                and (not project_root
                    or #deno_lock_root > #project_root))
            or (deno_root
                and (not project_root
                    or #deno_root >= #project_root))
        then
            -- deno config is closer than or equal to package manager lock,
            -- or deno lock is closer than package manager lock. Attach at the project root,
            -- or deno lock or deno config path. At least one of these is always set at this point.
            on_dir(project_root or deno_lock_root or deno_root)
        end

        local node_markers = {
            'package.json',
            'package-lock.json',
            'yarn.lock',
            'pnpm-lock.yaml',
            'bun.lockb',
            'bun.lock',
        }

        if vim.fs.root(bufnr, node_markers) then
            -- use ts_ls in a non-deno workspace
            return
        end

        -- use deno as default js/ts file lsp, so return cwd
        on_dir(project_root or vim.fn.getcwd())
    end,
    ---@type lspconfig.settings.denols
    settings = {
        deno = {
            enable = true,
            suggest = {
                imports = {
                    autoDiscover = true,
                    hosts = {
                        ['https://deno.land'] = true,
                    },
                },
            },
            codeLens = {
                implementations = true,
                references = true,
            },
            inlayHints = {
                functionLikeReturnTypes = {
                    enabled = true,
                },
                propertyDeclarationTypes = {
                    enabled = true,
                },
                variableTypes = {
                    enabled = true,
                },
            },
            organizeImports = {
                enabled = true,
            },
        },
    },
}
