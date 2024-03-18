require("spectre").setup {
    is_block_ui_break = true,
    mapping = {
        ['tab'] = {
            map = '<Tab>',
            cmd = "<cmd>lua require('spectre').tab()<cr>",
            desc = 'Next query',
        },
        ['shift-tab'] = {
            map = '<S-Tab>',
            cmd = "<cmd>lua require('spectre').tab_shift()<cr>",
            desc = 'Previous query',
        },
        ['toggle_line'] = {
            map = "dd",
            cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
            desc = "Toggle item",
        },
        ['enter_file'] = {
            map = "<cr>",
            cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
            desc = "Open file",
        },
        ['send_to_qf'] = {
            map = "<leader>rq",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "Send all items to quickfix",
        },
        ['replace_cmd'] = {
            map = "<leader>rc",
            cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
            desc = "Input replace command",
        },
        ['show_option_menu'] = {
            map = "<leader>ro",
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = "Show options",
        },
        ['run_current_replace'] = {
            map = "<leader>rc",
            cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
            desc = "Replace current line",
        },
        ['run_replace'] = {
            map = "<leader>rr",
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = "Replace all",
        },
        ['change_view_mode'] = {
            map = "<leader>rv",
            cmd = "<cmd>lua require('spectre').change_view()<CR>",
            desc = "Change result view mode",
        },
        ['change_replace_sed'] = {
            map = "<leader>rtrs",
            cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
            desc = "Use Sed to replace",
        },
        ['change_replace_oxi'] = {
            map = "<leader>rtrs",
            cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
            desc = "Use Oxi to replace",
        },
        ['toggle_live_update']={
            map = "<leader>rtu",
            cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
            desc = "Update when Vim writes to file",
        },
        ['toggle_ignore_case'] = {
            map = "<leader>rti",
            cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
            desc = "Toggle ignore case",
        },
        ['toggle_ignore_hidden'] = {
            map = "<leader>rth",
            cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
            desc = "Toggle search hidden",
        },
        ['resume_last_search'] = {
            map = "<leader>rl",
            cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
            desc = "Repeat last search",
        },
    },
}

vim.keymap.set(
    'n',
    '<leader>rt',
    '<cmd>lua require("spectre").toggle()<CR>',
    { desc = "Toggle Spectre" }
)

vim.keymap.set(
    'n',
    '<leader>rw',
    '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
    { desc = "Search the current word" }
)

vim.keymap.set(
    'v',
    '<leader>rw',
    '<esc><cmd>lua require("spectre").open_visual()<CR>',
    { desc = "Search the current word" }
)

vim.keymap.set(
    'n',
    '<leader>rf',
    '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
    { desc = "Search the current file" }
)
