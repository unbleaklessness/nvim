require("chatgpt").setup({
    api_key_cmd = "cat " .. vim.fn.expand("$HOME") .. "/gpt_api_key.txt",
    chat = {
        border_left_sign = "",
        border_right_sign = "",
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
            -- delete_session = "<leader>ad",
            delete_session = "D",
            -- delete_message = "<leader>ad",
            delete_message = "d",
            -- close = "<leader>aq",
            close = "<C-c>",
            -- yank_last_code = "<leader>ay",
            yank_last_code = "<C-y>",
            -- yank_last = "<leader>aY",
            yank_last = "<C-S-y>",
            -- cycle_modes = "<leader>am",
            cycle_modes = "<C-v>",
            -- toggle_settings = "<leader>as",
            toggle_settings = "<C-s>",
            -- next_message = "<leader>an",
            next_message = "<C-j>",
            -- prev_message = "<leader>ap",
            prev_message = "<C-k>",
            -- rename_session = "<leader>ai",
            rename_session = "r",
            -- stop_generating = "<leader>ax",
            stop_generating = "<C-x>",
            -- new_session = "<leader>an",
            new_session = "<C-n>",
            cycle_windows = "<Tab>",
            -- toggle_message_role = "<leader>at",
            toggle_message_role = "<NOP>",
            -- toggle_system_role_open = "<leader>aS",
            toggle_system_role_open = "<NOP>",
        },
    },
    edit_with_instructions = {
        keymaps = {
            -- close = "<leader>aq",
            close = "<C-c>",
            -- accept = "<leader>ay",
            accept = "<C-y>",
            -- toggle_diff = "<leader>ad",
            toggle_diff = "<NOP>",
            -- toggle_help = "<leader>ah",
            toggle_help = "<NOP>",
            -- toggle_settings = "<leader>as",
            toggle_settings = "<C-s>",
            cycle_windows = "<Tab>",
            -- use_output_as_input = "<leader>au",
            use_output_as_input = "<C-i>",
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

vim.keymap.set("n", "<leader>ac", ":ChatGPT<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>aC", ":ChatGPTCompleteCode<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>ar", ":ChatGPTRun ", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>ae", ":ChatGPTEditWithInstructions<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>aa", ":ChatGPTActAs<CR>", { noremap = true, silent = true })
