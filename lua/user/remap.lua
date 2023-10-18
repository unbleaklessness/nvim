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
