local built_in = require("telescope.builtin")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local telescope = require("telescope")
local previewers = require("telescope.previewers")
local previewers_utils = require("telescope.previewers.utils")
local large_buffers = require("config.large_buffers")

local truncate_large_files = function(file_path, buffer_number, options)
    options = options or {}
    file_path = vim.fn.expand(file_path)
    if type(file_path) ~= "string" then
        return
    end
    vim.loop.fs_stat(file_path, function(_, stats)
        if not stats then
            return
        end
        local max_size = large_buffers.LARGE_BUFFER_SIZE
        if stats.size > max_size then
            local command = { "head", "-c", max_size, file_path }
            previewers_utils.job_maker(command, buffer_number, options)
        else
            previewers.buffer_previewer_maker(file_path, buffer_number, options)
        end
    end)
end

telescope.setup({
    pickers = {
        find_files = {
            find_command = {
                "fd",

                -- Required by Telescope.
                "--color",
                "never",

                -- What to search.
                "--type",
                "file",
                "--type",
                "symlink",

                -- Other.
                "--strip-cwd-prefix", -- Do not show the `./` prefix.
                "--hidden", -- Show hidden files (such as dot files).
                "--no-ignore", -- Show files ignored by `.gitignore`.

                -- Exclude from find.

                "--exclude",
                ".git/",

                "--exclude",
                "node_modules/",

                "--exclude",
                "venv/",

                "--exclude",
                "build/",

                "--exclude",
                "cmake-build-debug/",

                "--exclude",
                ".cache/",

                "--exclude",
                ".idea/",

                "--exclude",
                "__init__.py",

                "--exclude",
                "CMakeFiles/",

                "--exclude",
                "worktrees/",
           },
        },
        buffers = {
            sort_lastused = true,
        },
    },
    defaults = {
        path_display = { "truncate" },
        vimgrep_arguments = {
            "rg",

            -- Required by Telescope.
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",

            -- Other.
            "--smart-case",
            "--hidden", -- Show hidden files (such as dot files).
            "--no-ignore-vcs", -- Show files ignored by `.gitignore`.

            -- Exclude from grep.

            "--glob",
            "!.git/",

            "--glob",
            "!node_modules/",

            "--glob",
            "!venv/",

            "--glob",
            "!build/",

            "--glob",
            "!cmake-build-debug/",

            "--glob",
            "!.cache/",

            "--glob",
            "!.idea/",

            "--glob",
            "!__init__.py",

            "--glob",
            "!CMakeFiles/",

            "--glob",
            "!worktrees/",
        },
        buffer_previewer_maker = truncate_large_files,
    },
    extensions = {
        file_browser = {
            hidden = true, -- Show hidden files (such as dot files).
            respect_gitignore = false,
        },
        undo = {
            mappings = {
                i = {
                    ["<C-y>"] = require("telescope-undo.actions").restore,
                },
            },
            use_delta = true,
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
                preview_height = 0.7,
            },
        },
    },
})

telescope.load_extension("file_browser")
telescope.load_extension("undo")
telescope.load_extension("fzf")

local find_in_directory = function(options)
    options = options or {}
    local grep = options.grep or false
    local path = options.path or (vim.env.HOME .. "/")

    pickers
        .new(options, {
            prompt_title = "Find in Directory",
            sorter = config.generic_sorter({}),
            previewer = config.file_previewer({}),

            finder = finders.new_oneshot_job({
                "fd",

                -- Required by this.
                "--base-directory",
                path,

                -- Required by Telescope.
                "--color",
                "never",

                -- What to search.
                "--type",
                "directory",

                -- Other.
                -- "--max-depth",
                -- "3",
                "--hidden", -- Show hidden files (such as dot files).
                "--no-ignore", -- Show files ignored by `.gitignore`.

                -- Exclude from find.

                "--exclude",
                ".git/",

                "--exclude",
                "node_modules/",

                "--exclude",
                "venv/",

                "--exclude",
                "build/",

                "--exclude",
                "cmake-build-debug/",

                "--exclude",
                ".cache/",

                "--exclude",
                ".idea/",
            }, {}),

            attach_mappings = function(prompt_buffer_number, _)
                actions.select_default:replace(function()
                    actions.close(prompt_buffer_number)
                    local selection = action_state.get_selected_entry()
                    if not selection then
                        return
                    end
                    if grep then
                        built_in.live_grep({ cwd = selection[1] })
                    else
                        built_in.find_files({ cwd = selection[1] })
                    end
                end)
                return true
            end,
        })
        :find()
end

vim.keymap.set("n", "<leader>ff", built_in.find_files, { noremap = true, silent = true })

-- UNUSED.
-- vim.keymap.set("n", "<leader>fih", function()
--     find_in_directory({ path = vim.env.HOME .. "/" })
-- end, { noremap = true, silent = true })

-- UNUSED.
-- vim.keymap.set("n", "<leader>Fih", function()
--     find_in_directory({ path = vim.env.HOME .. "/", grep = true })
-- end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>fidg", function()
    find_in_directory({ path = vim.fn.getcwd() .. "/", grep = true })
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>fidf", function()
    find_in_directory({ path = vim.fn.getcwd() .. "/", grep = false })
end, { noremap = true, silent = true })

-- UNUSED.
-- vim.keymap.set("n", "<leader>fir", function()
--     find_in_directory({ path = "/" })
-- end, { noremap = true, silent = true })

-- UNUSED.
-- vim.keymap.set("n", "<leader>Fir", function()
--     find_in_directory({ path = "/", grep = true })
-- end, { noremap = true, silent = true })

-- UNUSED.
-- vim.keymap.set("n", "<leader>fic", function()
--     builtin.find_files({ cwd = plenary_path.new(vim.env.MYVIMRC):parent().filename })
-- end, { noremap = true, silent = true })

-- UNUSED.
-- vim.keymap.set("n", "<leader>Fic", function()
--     builtin.find_files({ cwd = plenary_path.new(vim.env.MYVIMRC):parent().filename, grep = true })
-- end, { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope file_browser<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
    "n",
    "<leader>fc",
    ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
    "n",
    "<leader>ls",
    ":Telescope lsp_dynamic_workspace_symbols<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>tr", ":Telescope resume<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>tf", ":Telescope oldfiles<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>tb", ":Telescope buffers<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>gi", ":Telescope git_status<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>gb", ":Telescope git_branches<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>gc", ":Telescope git_commits<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>gC", ":Telescope git_bcommits<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>gh", ":Telescope git_stash<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>tu", function()
    require("telescope").extensions.undo.undo()
end, { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>th", ":Telescope help_tags<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>tm", ":Telescope marks<CR>", { noremap = true, silent = true })

-- vim.keymap.set("n", "<leader>lr", function()
--     builtin.lsp_references({ trim_text = true, show_line = false })
-- end, { noremap = true, silent = true })
vim.keymap.set("n", "gr", function()
    built_in.lsp_references({ trim_text = true, show_line = false })
end, { noremap = true, silent = true })
