local builtin = require('telescope.builtin')
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local config = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local telescope = require('telescope')
local path = require('plenary.path')
local previewers = require("telescope.previewers")

vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true, silent = true })

telescope.setup {
    pickers = {
        find_files = {
            find_command = {
                "fdfind",

                -- Required by Telescope.
                "--color", "never",

                -- What to search.
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
                '--exclude', '.idea/',
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
            '--glob', '!.idea/',
        },
    },
    extensions = {
        file_browser = {
            hidden = true, -- Show hidden files (such as dot files).
        },
        undo = {
            mappings = {
                i = {
                    ["<CR>"] = require("telescope-undo.actions").restore,
                },
            },
        },
    },
}

telescope.load_extension "file_browser"
telescope.load_extension "undo"
telescope.load_extension "fzf"

local find_in_directory = function(options)
    options = options or {
        path = vim.env.HOME .. "/",
    }
    pickers.new(options, {
        prompt_title = "Find in Directory",
        default_text = options.path,

        finder = finders.new_oneshot_job({
            "fdfind",

            -- Required by this.
            "--base-directory", options.path,
            "--absolute-path",

            -- Required by Telescope.
            "--color", "never",

            -- What to search.
            "--type", "directory",

            -- Other.
            "--max-depth", "3",
            "--hidden", -- Show hidden files (such as dot files).
            "--no-ignore", -- Show files ignored by `.gitignore`.

            -- Exclude from find.
            '--exclude', '.git/',
            '--exclude', 'node_modules/',
            '--exclude', 'venv/',
            '--exclude', 'build/',
            '--exclude', 'cmake-build-debug/',
            '--exclude', '.cache/',
            '--exclude', '.idea/',
        }, {}),

        sorter = config.generic_sorter(),

        previewer = config.file_previewer(),
        -- previewer = previewers.new_termopen_previewer({
        --     get_command = function(entry, status)
        --         return { 'ls', '-a1', entry.value }
        --     end,
        -- }),

        attach_mappings = function(prompt_buffer_number, _)
            actions.select_default:replace(function()
                actions.close(prompt_buffer_number)
                local selection = action_state.get_selected_entry()
                if selection then
                    builtin.find_files({ cwd = selection[1] })
                end
            end)
            return true
        end,
    }):find()
end

vim.keymap.set(
    "n",
    "<leader>fih",
    function() find_in_directory({ path = vim.env.HOME .. "/" }) end,
    { noremap = true, silent = true }
)

vim.keymap.set(
    "n",
    "<leader>fid",
    function() find_in_directory({ path = vim.fn.getcwd() .. "/" }) end,
    { noremap = true, silent = true }
)

vim.keymap.set(
    "n",
    "<leader>fir",
    function() find_in_directory({ path = "/" }) end,
    { noremap = true, silent = true }
)

vim.keymap.set(
    "n",
    "<leader>fic",
    function() builtin.find_files { cwd = path.new(vim.env.MYVIMRC):parent().filename } end,
    { noremap = true, silent = true }
)

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
