--- @diagnostic disable-next-line: missing-fields
require("auto-session").setup({
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "/" },
    auto_save_enabled = true,
    pre_save_cmds = { "NvimTreeClose" },
})

vim.api.nvim_set_keymap("n", "<leader>ss", ":SessionSave<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sd", ":SessionDelete<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sr", ":SessionRestore<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<leader>sf",
    ":Telescope session-lens search_session<CR>",
    { noremap = true, silent = true }
)
