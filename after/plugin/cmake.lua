require("cmake-tools").setup({
    cmake_regenerate_on_save = false,
    cmake_build_options = { "-j 8" },
    cmake_dap_configuration = {
        name = "cpp",
        type = "cppdbg",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
    },
    cmake_build_directory = "build/${variant:buildType}",
    cmake_executor = {
        name = "quickfix",
        default_opts = {
            quickfix = {
                show = "always",
                position = "botright",
                size = 10,
                encoding = "utf-8",
                auto_close_when_success = true,
            },
        },
    },
    cmake_runner = {
        name = "toggleterm",
        default_opts = {
            toggleterm = {
                direction = "float",
                close_on_exit = false,
                auto_scroll = true,
            },
        },
    },
})

vim.api.nvim_set_keymap("n", "<leader>cr", ":CMakeRun<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>coe", ":CMakeOpenExecutor<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cor", ":CMakeOpenRunner<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cd", ":CMakeDebug<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cb", ":CMakeBuild<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cB", ":CMakeBuild!<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cc", ":CMakeClean<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
    "n",
    "<leader>cx",
    ":CMakeStopExecutor<CR>:CMakeStopRunner<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>cq",
    ":CMakeCloseExecutor<CR>:CMakeCloseRunner<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>ctb", ":CMakeSelectBuildTarget<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>ctl", ":CMakeSelectLaunchTarget<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cTb", ":CMakeSelectBuildType<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>ci", ":CMakeInstall<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cg", ":CMakeGenerate<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cG", ":CMakeGenerate!<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cs", ":CMakeSettings<CR>", { noremap = true, silent = true })
