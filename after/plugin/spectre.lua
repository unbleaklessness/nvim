require("spectre").setup {
    is_block_ui_break = true,
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
