local dap = require("dap")

dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "OpenDebugAD7",
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input({ "Path to executable: ", vim.fn.getcwd() .. "/", "file" })
        end,
        cwd = function()
            return vim.fn.input({ "Working directory: ", vim.fn.getcwd() .. "/", "file" })
        end,
        stopAtEntry = true,
    },
    {
        name = "Attach to GDB server :2000",
        type = "cppdbg",
        request = "launch",
        MIMode = "gdb",
        miDebuggerServerAddress = "localhost:2000",
        miDebuggerPath = "/usr/bin/gdb",
        cwd = "${workspaceFolder}",
        program = function()
            return vim.fn.input({ "Path to executable: ", vim.fn.getcwd() .. "/", "file" })
        end,
    },
}

vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dt", ":DapTerminate<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ds", ":DapStepOver<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>di", ":DapStepInto<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>do", ":DapStepOut<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dr", ":DapRestartFrame<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>dl", function()
    require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>dj", function()
    require("dap").run_last()
end, { noremap = true, silent = true })

require("dapui").setup()
require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })

vim.keymap.set("n", "<leader>du", function()
    require("dapui").toggle()
end, { noremap = true, silent = true })
