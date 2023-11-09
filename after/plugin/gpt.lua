require("chatgpt").setup({
    api_key_cmd = 'cat ' .. vim.fn.expand("$HOME") .. '/gpt_api_key.txt',
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
