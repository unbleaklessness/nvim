require("chatgpt").setup({
    api_key_cmd = 'cat ' .. vim.fn.expand("$HOME") .. '/gpt_api_key.txt',
    chat = {
        sessions_window = {
            active_sign = " + ",
            inactive_sign = " - ",
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
