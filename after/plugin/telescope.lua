local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

local telescope = require('telescope')

telescope.load_extension "file_browser"

telescope.setup {
    pickers = {
        find_files = {
            hidden = true,
        },
    },
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
        },
    },
}

vim.api.nvim_set_keymap(
    "n",
    "<leader>fb",
    ":Telescope file_browser<CR>",
    { noremap = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>fc",
    ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { noremap = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>fg",
    ":Telescope live_grep<CR>",
    { noremap = true }
)
