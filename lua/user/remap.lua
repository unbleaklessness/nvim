vim.api.nvim_set_keymap(
    "n",
    "<leader><leader>",
    ":source $MYVIMRC<CR>",
    { noremap = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>tt",
    ":!gnome-terminal<CR><CR>",
    { noremap = true }
)

vim.api.nvim_set_keymap("n", "<leader>y", "\"+y", { noremap = false })
vim.api.nvim_set_keymap("v", "<leader>y", "\"+y", { noremap = false })

vim.api.nvim_set_keymap("n", "<leader>Y", "\"+Y", { noremap = false })
vim.api.nvim_set_keymap("v", "<leader>Y", "\"+Y", { noremap = false })

vim.api.nvim_set_keymap("n", "<leader>p", "\"+p", { noremap = false })
vim.api.nvim_set_keymap("v", "<leader>p", "\"+p", { noremap = false })

vim.api.nvim_set_keymap("n", "<leader>P", "\"+P", { noremap = false })
vim.api.nvim_set_keymap("v", "<leader>P", "\"+P", { noremap = false })
