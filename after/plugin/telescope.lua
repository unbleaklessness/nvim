local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true, silent = true })

local telescope = require('telescope')

telescope.setup {
    pickers = {
        find_files = {
            hidden = true, -- Show hidden files (such as dot files).
            no_ignore = true, -- Show files ignored by `.gitignore`.
        },
    },
    defaults = {
        path_display = { "truncate" },
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
            '.git/',
            'node_modules/',
            'venv/',
            'build/',
            '.cache/',
        },
    },
    extensions = {
        file_browser = {
            hidden = true, -- Show hidden files (such as dot files).
        },
    },
}

telescope.load_extension "file_browser"
telescope.load_extension "undo"

vim.api.nvim_set_keymap(
    "n",
    "<leader>fb",
    ":Telescope file_browser<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>fc",
    ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>fg",
    ":Telescope live_grep<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>lr",
    ":Telescope lsp_references<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>ls",
    ":Telescope lsp_dynamic_workspace_symbols<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>r",
    ":Telescope resume<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>/",
    ":Telescope current_buffer_fuzzy_find<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>?",
    ":Telescope oldfiles<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>b",
    ":Telescope buffers<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>gi",
    ":Telescope git_status<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>gb",
    ":Telescope git_branches<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>gc",
    ":Telescope git_commits<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>gC",
    ":Telescope git_bcommits<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>gt",
    ":Telescope git_stash<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>u",
    ":Telescope undo<CR>",
    { noremap = true, silent = true }
)
