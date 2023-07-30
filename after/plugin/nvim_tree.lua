-- Disable NetRW.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

-- vim.api.nvim_del_keymap(
--     "n",
--     "<leader>ft"
-- )

vim.api.nvim_set_keymap(
    "n",
    "<leader>ft",
    ":NvimTreeToggle<CR>",
    { noremap = false }
)
