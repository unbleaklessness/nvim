local dap = require("dap")

dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "OpenDebugAD7",
}

dap.configurations.cpp = {}

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

vim.keymap.set("n", "<leader>dC", function()
    require("dap").run_last()
end, { noremap = true, silent = true })

require("dapui").setup()
require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })

vim.keymap.set("n", "<leader>du", function()
    require("dapui").toggle()
end, { noremap = true, silent = true })
