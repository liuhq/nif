local icons = ConfigUtil.icons
local set = vim.keymap.set

local fzf = require('fzf-lua')

fzf.setup({
    fzf_opts = {
        ['--marker'] = '+',
        ['--marker-multi-line'] = '+│└',
        ['--pointer'] = '▌',
        ['--separator'] = '─',
        ['--scrollbar'] = '│',
        ['--info'] = 'right',
        ['--multi'] = true,
    },
    fzf_colors = {
        true,
    },
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
set('n', '<leader><space>', fzf.files, { desc = '[FZF] Files' })
set('n', '<leader>b', fzf.buffers, { desc = '[FZF] Buffers' })
set('n', '<leader>tt', fzf.tabs, { desc = '[FZF] Tabs' })
set('n', '<leader>fq', fzf.quickfix, { desc = '[FZF] Quickfix list' })
--- Search
set('n', '<leader>ss', fzf.grep, { desc = '[FZF] Grep' })
set('n', '<leader>sS', fzf.live_grep, { desc = '[FZF] Live grep current project' })
set('n', '<leader>sg', fzf.live_grep_glob, { desc = '[FZF] Live grep with glob' })
set('n', '<leader>sb', fzf.grep_curbuf, { desc = '[FZF] Search current buffer' })
set('n', '<leader>sB', fzf.lgrep_curbuf, { desc = '[FZF] Live grep current buffer' })
set('n', '<leader>sc', fzf.grep_cword, { desc = '[FZF] Search word under cursor' })
set('n', '<leader>sv', fzf.grep_visual, { desc = '[FZF] Search visual selection' })
--- tags
set('n', '<leader>ct', fzf.tags, { desc = '[FZF] Search project tags' })
set('n', '<leader>cT', fzf.btags, { desc = '[FZF] Search buffer tags' })
--- git
set('n', '<leader>gg', fzf.git_status, { desc = '[FZF] git status' })
set('n', '<leader>gw', fzf.git_worktrees, { desc = '[FZF] git worktrees' })
set('n', '<leader>gh', fzf.git_stash, { desc = '[FZF] git stash' })
--- LSP
set('n', '<leader>cr', function ()
    fzf.lsp_references({ ignore_current_line = true })
end, { desc = '[FZF] LSP references' })
set('n', '<leader>cd', fzf.lsp_document_symbols, { desc = '[FZF] LSP document symbols' })
set('n', '<leader>df', fzf.diagnostics_document, { desc = '[FZF] Current file diagnostics' })
set('n', '<leader>dw', fzf.diagnostics_workspace, { desc = '[FZF] Workspace diagnostics' })
--- Misc
set('n', '<leader>ah', fzf.highlights, { desc = '[FZF] Highlight groups' })
set('n', '<leader>ac', fzf.commands, { desc = '[FZF] Commands' })
set('n', '<leader>ao', fzf.nvim_options, { desc = '[FZF] Options' })
set('n', '<leader>ak', fzf.keymaps, { desc = '[FZF] Key mappings' })
set('n', '<leader>ft', fzf.filetypes, { desc = '[FZF] Filetypes' })
set('n', '<leader>cp', fzf.spellcheck, { desc = '[FZF] Spellcheck' })
set('n', '<leader>cP', fzf.spell_suggest, { desc = '[FZF] Spell suggest' })
--- nvim-dap
set('n', '<leader>v<cr>', fzf.dap_commands, { desc = '[FZF] Dap commands' })
set('n', '<leader>vq', fzf.dap_configurations, { desc = '[FZF] Dap configurations' })
set('n', '<leader>vo', fzf.dap_breakpoints, { desc = '[FZF] Dap breakpoints' })
set('n', '<leader>va', fzf.dap_variables, { desc = '[FZF] Dap variables' })
set('n', '<leader>vs', fzf.dap_frames, { desc = '[FZF] Dap frames' })
--- Completion Functions
set({ 'x', 'i' }, '<C-p>', function ()
    local save_dir = vim.fn.chdir(vim.fn.expand('%:p:h'))
    if save_dir ~= '' then
        fzf.complete_path()
        vim.fn.chdir(save_dir)
    end
end, { desc = '[FZF] Fuzzy complete path' })
