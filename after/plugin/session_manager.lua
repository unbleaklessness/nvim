-- local config = require('session_manager.config')
--
-- require('session_manager').setup({
--     autoload_mode = config.AutoloadMode.CurrentDir,
--     autosave_only_in_session = true,
-- })
--
-- vim.api.nvim_set_keymap("n", "<leader>ss", ":SessionManager save_current_session<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>sd", ":SessionManager delete_session<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>sl", ":SessionManager load_session<CR>", { noremap = true, silent = true })

require("auto-session").setup {
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "/" },
    auto_save_enabled = true,
    pre_save_cmds = { "NvimTreeClose" },
}

require('session-lens').setup({})

vim.api.nvim_set_keymap("n", "<leader>ss", ":SessionSave<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sd", ":SessionDelete<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sr", ":SessionRestore<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sf", ":Telescope session-lens search_session<CR>", { noremap = true, silent = true })
