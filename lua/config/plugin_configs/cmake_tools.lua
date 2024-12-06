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

vim.api.nvim_set_keymap("n", "<leader>ci", ":CMakeInstall<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cg", ":CMakeGenerate<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cG", ":CMakeGenerate!<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cs", ":CMakeSettings<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>cp", ":CMakeSelectConfigurePreset<CR>", { noremap = true, silent = true })

local remote_debug_terminal = nil

local function trim_string(s)
    return s:gsub("%s+", "")
end

-- Remote debug.
-- Generate CMake, build executable, upload executable, attach debugger.
vim.keymap.set("n", "<leader>cR", function()
    if remote_debug_terminal ~= nil then
        remote_debug_terminal:shutdown()
    end
    require("cmake-tools").generate({}, function()
        require("cmake-tools").build({}, function()
            remote_debug_terminal = require("toggleterm.terminal").Terminal:new({
                cmd = "./upload_and_debug.sh",
                close_on_exit = true,
                on_stdout = function(terminal, job, data, name)
                    for index, value in ipairs(data) do
                        if trim_string(value) == "OK" then
                            require("dap").terminate({}, {}, function()
                                require("dap").continue()
                            end)
                            return
                        end
                    end
                end,
                on_exit = function()
                    remote_debug_terminal = nil
                end,
            })
            remote_debug_terminal:open()
        end)
    end)
end, { noremap = true, silent = true })
