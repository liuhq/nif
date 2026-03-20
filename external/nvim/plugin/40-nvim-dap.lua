local dap = require('dap')
local dap_widgets = require('dap.ui.widgets')
local dap_view = require('dap-view')

vim.fn.sign_define('DapBreakpoint', { text = ConfigUtil.icons.dap.Breakpoint })
vim.fn.sign_define('DapBreakpointCondition', { text = ConfigUtil.icons.dap.BreakpointCondition })
vim.fn.sign_define('DapLogPoint', { text = ConfigUtil.icons.dap.LogPoint })
vim.fn.sign_define('DapStopped', { text = ConfigUtil.icons.dap.Stopped })

vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Dap start/continue' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Dap step over' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Dap step into' })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Dap step out' })
vim.keymap.set('n', '<leader>vR', dap.restart, { desc = 'Dap restart' })
vim.keymap.set('n', '<leader>vP', dap.pause, { desc = 'Dap pause' })
vim.keymap.set('n', '<leader>vt', dap.terminate, { desc = 'Dap terminate' })
vim.keymap.set('n', '<leader>vb', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>vB', function ()
    dap.set_breakpoint(vim.fn.input('Condition: '), nil, nil)
end, { desc = 'Set condition breakpoint' })
vim.keymap.set('n', '<leader>vh', function ()
    dap.set_breakpoint(nil, vim.fn.input('Hit count("number"): '), nil)
end, { desc = 'Set hit count breakpoint' })
vim.keymap.set('n', '<leader>vl', function ()
    dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, { desc = 'Set log breakpoint' })
vim.keymap.set('n', '<leader>vc', dap.clear_breakpoints, { desc = 'Removes all breakpoints' })
vim.keymap.set('n', '<leader>vr', dap.repl.toggle, { desc = 'Dap REPL' })
vim.keymap.set({ 'n', 'v' }, '<leader>vk', dap_widgets.hover, { desc = 'Dap widget hover' })
vim.keymap.set({ 'n', 'v' }, '<leader>vp', dap_widgets.preview, { desc = 'Dap widget preview' })
vim.keymap.set('n', '<leader>vf', function ()
    dap_widgets.centered_float(dap_widgets.frames)
end, { desc = 'Dap widget frames' })
vim.keymap.set('n', '<leader>vfu', dap.up, { desc = 'Go up stacktrace' })
vim.keymap.set('n', '<leader>vfd', dap.down, { desc = 'Go down stacktrace' })
vim.keymap.set('n', '<leader>vC', dap.run_to_cursor, { desc = 'Run to cursor' })

--- nvim-dap-view
dap_view.setup({
    controls = { enabled = true },
})

vim.keymap.set('n', '<leader>vv', dap_view.toggle, { desc = 'Toggle dap view' })
vim.keymap.set('n', '<leader>ve', dap_view.add_expr, { desc = 'Add expression at cursor' })

--- C/C++ - pkgs.gdb
--- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#c-c-rust-via-gdb
dap.adapters.gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
}
dap.configurations.c = {
    {
        name = 'Launch',
        type = 'gdb',
        request = 'launch',
        program = function ()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = {}, -- provide arguments if needed
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = 'Select and attach to process',
        type = 'gdb',
        request = 'attach',
        program = function ()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function ()
            local name = vim.fn.input('Executable name (filter): ')
            return require('dap.utils').pick_process({ filter = name })
        end,
        cwd = '${workspaceFolder}',
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:1234',
        program = function ()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
    },
}
dap.configurations.cpp = dap.configurations.c

--- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#more-rust-specific-set-up
dap.adapters['rust-gdb'] = {
    type = 'executable',
    command = 'rust-gdb',
    args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
}
dap.configurations.rust = {
    {
        name = 'Launch',
        type = 'rust-gdb',
        request = 'launch',
        program = function ()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = {}, -- provide arguments if needed
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = 'Select and attach to process',
        type = 'rust-gdb',
        request = 'attach',
        program = function ()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function ()
            local name = vim.fn.input('Executable name (filter): ')
            return require('dap.utils').pick_process({ filter = name })
        end,
        cwd = '${workspaceFolder}',
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'rust-gdb',
        request = 'attach',
        target = 'localhost:1234',
        program = function ()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
    },
}

--- C/C++/Rust - pkgs.lldb
--- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#c-c-rust-via-lldb-vscode
--- Rust config via rustaceanvim
dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb-dap',
    name = 'lldb',
}
dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function ()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        --- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#environment-variables
        env = function ()
            local variables = {}
            for k, v in pairs(vim.fn.environ()) do
                table.insert(variables, string.format('%s=%s', k, v))
            end
            return variables
        end,
    },
    {
        -- If you get an "Operation not permitted" error using this, try disabling YAMA:
        --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        name = 'Attach to process',
        type = 'cpp', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
        request = 'attach',
        pid = require('dap.utils').pick_process,
        args = {},
    },
}

--- Javascript - pkgs.vscode-js-debug
--- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#vscode-js-debug-1
dap.adapters['pwa-node'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
        command = 'js-debug',
        args = { '${port}' },
    },
}
--- Node
dap.configurations.javascript = {
    {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
    },
}
--- Deno
dap.configurations.typescript = {
    {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        runtimeExecutable = 'deno',
        runtimeArgs = {
            'run',
            '--inspect-wait',
            '--allow-all',
        },
        program = '${file}',
        cwd = '${workspaceFolder}',
        attachSimplePort = 9229,
    },
}

--- Godot
--- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#godot-gdscript
dap.adapters.godot = {
    type = 'server',
    host = '127.0.0.1',
    port = 6006,
}
dap.configurations.gdscript = {
    {
        type = 'godot',
        request = 'launch',
        name = 'Launch scene',
        project = '${workspaceFolder}',
    },
}
