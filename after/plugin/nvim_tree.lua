-- Disable NetRW.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    git = {
        ignore = false, -- Show files ignored by `.gitignore`.
    },
    view = {
        relativenumber = true,
        number = true,
        adaptive_size = true,
        centralize_selection = true,
        preserve_window_proportions = true,
        signcolumn = "no",
    },
    renderer = {
        root_folder_label = ":p:~",
        icons = {
            git_placement = "after",
        },
        indent_markers = {
            enable = true,
            inline_arrows = false,
        },
    },
})

vim.api.nvim_set_keymap(
    "n",
    "<leader>ft",
    ":NvimTreeFindFileToggle<CR>",
    { noremap = false }
)
