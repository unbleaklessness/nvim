local config = require('session_manager.config')

require('session_manager').setup({
    autoload_mode = config.AutoloadMode.CurrentDir,
    autosave_only_in_session = true,
})

vim.api.nvim_set_keymap("n", "<leader>ss", ":SessionManager save_current_session<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>sd", ":SessionManager delete_session<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>sl", ":SessionManager load_session<CR>", { noremap = true })
