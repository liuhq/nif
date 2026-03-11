require('yazi').setup({
    open_for_directories = true,
    open_multiple_tabs = true,
    highlight_groups = {
        hovered_buffer = {
            link = 'NormalFloat',
        },
        hovered_buffer_in_same_directory = {
            link = 'Normal',
        },
    },
    floating_window_scaling_factor = 1,
    yazi_floating_window_border = 'none',
    keymaps = {
        show_help = '<f1>',
        open_file_in_vertical_split = '<c-v>',
        open_file_in_horizontal_split = '<c-s>',
        open_file_in_tab = false,
        grep_in_directory = false,
        replace_in_directory = false,
        cycle_open_buffers = '<tab>',
        copy_relative_path_to_selected_files = false,
        send_to_quickfix_list = '<c-q>',
        change_working_directory = '<c-g>',
    },
})

vim.keymap.set('n', '<leader>e', '<cmd>Yazi<cr>', { desc = 'Open yazi (Current file)' })
vim.keymap.set('n', '<leader>r', '<cmd>Yazi cwd<cr>', { desc = 'Open yazi (Root/cwd)' })

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function ()
        local ft = vim.bo.filetype

        if ft == 'man' then
            vim.notify('Open: ' .. vim.fn.expand('%:p'), vim.log.levels.INFO)
            return
        end

        if vim.fn.argc() == 0 then
            require('yazi').yazi()
            vim.notify('Open in ' .. vim.fn.getcwd(), vim.log.levels.INFO)
        end
    end,
})
