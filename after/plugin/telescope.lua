local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true, silent = true })

local telescope = require('telescope')

telescope.setup {
    pickers = {
        find_files = {
            find_command = {
                "fdfind",

                "--type", "file",
                "--type", "symlink",

                -- Other.
                "--strip-cwd-prefix", -- Do not show the `./` prefix.
                "--hidden", -- Show hidden files (such as dot files).
                "--no-ignore", -- Show files ignored by `.gitignore`.

                -- Exclude from find.
                '--exclude', '.git/',
                '--exclude', 'node_modules/',
                '--exclude', 'venv/',
                '--exclude', 'build/',
                '--exclude', 'cmake-build-debug/',
                '--exclude', '.cache/',
            },
        },
        buffers = {
            sort_lastused = true,
        },
    },
    defaults = {
        path_display = { "truncate" },
        vimgrep_arguments = {
            'rg',

            -- Required by Telescope.
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',

            -- Other.
            '--smart-case',
            '--hidden', -- Show hidden files (such as dot files).
            '--no-ignore-vcs', -- Show files ignored by `.gitignore`.

            -- Exclude from grep.
            '--glob', '!.git/',
            '--glob', '!node_modules/',
            '--glob', '!venv/',
            '--glob', '!build/',
            '--glob', '!cmake-build-debug/',
            '--glob', '!.cache/',
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
telescope.load_extension "fzf"

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
    "<leader>tr",
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
    "<leader>tf",
    ":Telescope oldfiles<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>tb",
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
    "<leader>tu",
    ":Telescope undo<CR>",
    { noremap = true, silent = true }
)
