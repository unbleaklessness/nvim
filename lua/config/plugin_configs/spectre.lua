require("spectre").setup({
    is_block_ui_break = true,
    mapping = {
        ["tab"] = {
            map = "<Tab>",
            cmd = "<cmd>lua require('spectre').tab()<cr>",
            desc = "Next query",
        },
        ["shift-tab"] = {
            map = "<S-Tab>",
            cmd = "<cmd>lua require('spectre').tab_shift()<cr>",
            desc = "Previous query",
        },
        ["toggle_line"] = {
            map = "dd",
            cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
            desc = "Toggle item",
        },
        ["enter_file"] = {
            map = "<cr>",
            cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
            desc = "Open file",
        },
        ["send_to_qf"] = {
            map = "<leader>rq",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "Send all items to quickfix",
        },
        ["replace_cmd"] = {
            map = "<leader>rc",
            cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
            desc = "Input replace command",
        },
        ["show_option_menu"] = {
            map = "<leader>ro",
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = "Show options",
        },
        ["run_current_replace"] = {
            map = "<leader>rc",
            cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
            desc = "Replace current line",
        },
        ["run_replace"] = {
            map = "<leader>ry",
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = "Replace all",
        },
        ["change_view_mode"] = {
            map = "<leader>rv",
            cmd = "<cmd>lua require('spectre').change_view()<CR>",
            desc = "Change result view mode",
        },
        ["change_replace_sed"] = {
            map = "<leader>rsrs",
            cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
            desc = "Use Sed to replace",
        },
        ["change_replace_oxi"] = {
            map = "<leader>rsro",
            cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
            desc = "Use Oxi to replace",
        },
        ["toggle_live_update"] = {
            map = "<leader>rsu",
            cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
            desc = "Update when Vim writes to file",
        },
        ["toggle_ignore_case"] = {
            map = "<leader>rsi",
            cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
            desc = "Toggle ignore case",
        },
        ["toggle_ignore_hidden"] = {
            map = "<leader>rsh",
            cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
            desc = "Toggle search hidden",
        },
        ["resume_last_search"] = {
            map = "<leader>rl",
            cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
            desc = "Repeat last search",
        },
    },
})

vim.keymap.set("n", "<leader>rt", '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })

-- vim.keymap.set(
--     "n",
--     "<leader>rf",
--     '<cmd>lua require("spectre").open_visual({ select_word = true })<CR>',
--     { desc = "Global search current word" }
-- )
--
-- vim.keymap.set(
--     "v",
--     "<leader>rf",
--     '<esc><cmd>lua require("spectre").open_visual()<CR>',
--     { desc = "Global search selection" }
-- )

vim.keymap.set(
    "n",
    "<leader>rf",
    '<cmd>lua require("spectre").open_file_search({ select_word = true, replace_text = vim.fn.expand("<cword>") })<CR>',
    { desc = "Current file search current word" }
)

-- This function does not work correctly:
function get_selected_text()
    local mode = vim.api.nvim_get_mode().mode

    if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
        return ""
    end

    local start_position = vim.fn.getpos("v")
    local stop_position = vim.fn.getpos(".")

    if
        start_position[2] > stop_position[2]
        or (start_position[2] == stop_position[2] and start_position[3] > stop_position[3])
    then
        local temporary = start_position
        start_position = stop_position
        stop_position = temporary
    end

    local lines = vim.fn.getregion(0, start_position, stop_position)

    if lines == nil or #lines == 0 then
        return ""
    end

    return table.concat(lines, "\n")
end

vim.keymap.set(
    "v",
    "<leader>rf",
    '<esc><cmd>lua require("spectre").open_file_search({ replace_text = get_selected_text() })<CR>',
    { desc = "Current file search selection" }
)
