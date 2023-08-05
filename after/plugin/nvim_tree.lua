-- Disable NetRW.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    git = {
        ignore = false, -- Show files ignored by `.gitignore`.
    },
})

vim.api.nvim_set_keymap(
    "n",
    "<leader>ft",
    ":NvimTreeToggle<CR>",
    { noremap = false }
)