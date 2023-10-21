vim.api.nvim_set_keymap(
    "n",
    "<leader>tt",
    ":!gnome-terminal<CR><CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>y", "\"+y", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>y", "\"+y", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>Y", "\"+Y", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>Y", "\"+Y", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>p", "\"+p", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>p", "\"+p", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>P", "\"+P", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>P", "\"+P", { noremap = true, silent = true })
