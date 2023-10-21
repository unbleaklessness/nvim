-- Set the color of the icons.
-- local icons = require'nvim-web-devicons'.get_icons()
-- for _, value in pairs(icons) do
--     value.color = "#A9B1D6"
-- end

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
        signcolumn = "auto",
    },
    diagnostics = {
        enable = true,
    },
    renderer = {
        root_folder_label = ":p:~",
        highlight_diagnostics = true,
        icons = {
            git_placement = "after",
            show = {
                folder_arrow = false,
            },
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


