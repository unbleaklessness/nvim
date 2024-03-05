require("chatgpt").setup({
    api_key_cmd = 'cat ' .. vim.fn.expand("$HOME") .. '/gpt_api_key.txt',
    chat = {
        sessions_window = {
            -- Default signs are broken with the NerdFont version that I am using.
            active_sign = " + ",
            inactive_sign = " - ",
        },
        keymaps = {
            -- Default `Draft message` key map conflicts with the default `Scroll down` key map.
            draft_message = "<NOP>",
            -- `Edit message` throws an error at the moment.  
            edit_message = "<NOP>",
            scroll_up = "<NOP>",
            scroll_down = "<NOP>",
            select_session = "<CR>",
            delete_session = "<leader>ad",
            delete_message = "<leader>ad",
            close = "<leader>aq",
            yank_last_code = "<leader>ay",
            yank_last = "<leader>aY",
            cycle_modes = "<leader>am",
            toggle_settings = "<leader>as",
            next_message = "<leader>an",
            prev_message = "<leader>ap",
            rename_session = "<leader>ai",
            stop_generating = "<leader>ax",
            new_session = "<leader>an",
            cycle_windows = "<Tab>",
            toggle_message_role = "<leader>at",
            toggle_system_role_open = "<leader>aS",
        }
    },
    edit_with_instructions = {
        keymaps = {
            close = "<leader>aq",
            accept = "<leader>ay",
            toggle_diff = "<leader>ad",
            toggle_settings = "<leader>as",
            cycle_windows = "<Tab>",
            use_output_as_input = "<leader>au",
        },
    },
    openai_params = {
        model = "gpt-3.5-turbo-16k",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 1024,
        temperature = 1,
        top_p = 1,
        n = 1,
    },
    openai_edit_params = {
        model = "gpt-3.5-turbo-16k",
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 1,
        top_p = 1,
        n = 1,
    },
})

vim.keymap.set(
    "n",
    "<leader>ac",
    ":ChatGPT<CR>",
    { noremap = true, silent = true }
)

vim.keymap.set(
    "n",
    "<leader>aC",
    ":ChatGPTCompleteCode<CR>",
    { noremap = true, silent = true }
)

vim.keymap.set(
    "n",
    "<leader>ar",
    ":ChatGPTRun ",
    { noremap = true, silent = true }
)

vim.keymap.set(
    "n",
    "<leader>ae",
    ":ChatGPTEditWithInstructions<CR>",
    { noremap = true, silent = true }
)

vim.keymap.set(
    "n",
    "<leader>aa",
    ":ChatGPTActAs<CR>",
    { noremap = true, silent = true }
)
