local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

local telescope = require('telescope')

telescope.setup {
    pickers = {
        find_files = {
            hidden = true, -- Show hidden files (such as dot files).
            no_ignore = true, -- Show files ignored by `.gitignore`.
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
            '--glob', '!.git/', -- Exclude from grep.
            '--glob', '!node_modules/', -- Exclude from grep.
        },
        file_ignore_patterns = {
            ".git/", "node_modules/",
        },
    },
    extensions = {
        file_browser = {
            hidden = true, -- Show hidden files (such as dot files).
        },
    },
}

telescope.load_extension "file_browser"

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
