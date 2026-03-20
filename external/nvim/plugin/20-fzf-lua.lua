local icons = ConfigUtil.icons

local fzf = require('fzf-lua')

---@param key string
---@param action string|function
---@param desc string
local keyset = function (key, action, desc)
    vim.keymap.set('n', key, action, { desc })
end

fzf.setup({
    winopts = {
        row = 0.50,
        col = 0.50,
        border = 'solid',
        preview = {
            border = 'solid',
            vertical = 'down:45%',
            horizontal = 'right:45%',
            layout = 'flex',
        },
    },
    lsp = {
        symbols = {
            symbol_style = 3,
        },
    },
    diagnostics = {
        signs = {
            ['Error'] = { text = icons.diagnostics.Error },
            ['Warn'] = { text = icons.diagnostics.Warn },
            ['Hint'] = { text = icons.diagnostics.Hint },
            ['Info'] = { text = icons.diagnostics.Info },
        },
    },
    ui_select = true,
})

--- Buffers and Files
keyset('<leader><space>', fzf.files, '[FZF] Files')
keyset('<leader>b', fzf.buffers, '[FZF] Buffers')
keyset('<leader>tt', fzf.tabs, '[FZF] Tabs')
keyset('<leader>fq', fzf.quickfix, '[FZF] Quickfix list')
--- Search
keyset('<leader>ss', fzf.grep, '[FZF] Grep')
keyset('<leader>sS', fzf.live_grep, '[FZF] Live grep current project')
keyset('<leader>sg', fzf.live_grep_glob, '[FZF] Live grep with glob')
keyset('<leader>sb', fzf.grep_curbuf, '[FZF] Search current buffer')
keyset('<leader>sB', fzf.lgrep_curbuf, '[FZF] Live grep current buffer')
keyset('<leader>sc', fzf.grep_cword, '[FZF] Search word under cursor')
keyset('<leader>sv', fzf.grep_visual, '[FZF] Search visual selection')
--- tags
keyset('<leader>ct', fzf.tags, '[FZF] Search project tags')
keyset('<leader>cT', fzf.btags, '[FZF] Search buffer tags')
--- git
keyset('<leader>gg', fzf.git_status, '[FZF] git status')
keyset('<leader>gw', fzf.git_worktrees, '[FZF] git worktrees')
keyset('<leader>gh', fzf.git_stash, '[FZF] git stash')
--- LSP
keyset('<leader>cr', function ()
    fzf.lsp_references({ ignore_current_line = true })
end, '[FZF] LSP references')
keyset('<leader>cd', fzf.lsp_document_symbols, '[FZF] LSP document symbols')
keyset('<leader>df', fzf.diagnostics_document, '[FZF] Current file diagnostics')
keyset('<leader>dw', fzf.diagnostics_workspace, '[FZF] Workspace diagnostics')
--- Misc
keyset('<leader>ah', fzf.highlights, '[FZF] Highlight groups')
keyset('<leader>ac', fzf.commands, '[FZF] Commands')
keyset('<leader>ao', fzf.nvim_options, '[FZF] Options')
keyset('<leader>ak', fzf.keymaps, '[FZF] Key mappings')
keyset('<leader>ft', fzf.filetypes, '[FZF] Filetypes')
keyset('<leader>cp', fzf.spellcheck, '[FZF] Spellcheck')
keyset('<leader>cP', fzf.spell_suggest, '[FZF] Spell suggest')
--- nvim-dap
keyset('<leader>v<cr>', fzf.dap_commands, '[FZF] Dap commands')
keyset('<leader>vq', fzf.dap_configurations, '[FZF] Dap configurations')
keyset('<leader>vo', fzf.dap_breakpoints, '[FZF] Dap breakpoints')
keyset('<leader>va', fzf.dap_variables, '[FZF] Dap variables')
keyset('<leader>vs', fzf.dap_frames, '[FZF] Dap frames')
--- Completion Functions
vim.keymap.set({ 'x', 'i' }, '<C-p>', function ()
    local save_dir = vim.fn.chdir(vim.fn.expand('%:p:h'))
    if save_dir ~= '' then
        fzf.complete_path()
        vim.fn.chdir(save_dir)
    end
end, { desc = '[FZF] Fuzzy complete path' })
