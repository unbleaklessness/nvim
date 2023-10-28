vim.api.nvim_set_keymap(
    "n",
    "<leader>tt",
    ":silent !kitty --detach tmux<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>qc",
    ":cclose<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>qn",
    ":cnext<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>qp",
    ":cprevious<CR>",
    { noremap = true, silent = true }
)

-- vim.api.nvim_set_keymap("v", "y", "ygv<Esc>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "Y", "Ygv<Esc>", { noremap = true, silent = true })
--
-- vim.api.nvim_set_keymap("n", "<leader>y", "\"+ygv<Esc>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>Y", "\"+Ygv<Esc>", { noremap = true, silent = true })
--
-- vim.api.nvim_set_keymap("v", "<leader>y", "\"+ygv<Esc>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<leader>Y", "\"+Ygv<Esc>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "y", "y", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "Y", "Y", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>y", "\"+y", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Y", "\"+Y", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "<leader>y", "\"+y", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>Y", "\"+Y", { noremap = true, silent = true })

local function bind_formatting_paste()
    vim.api.nvim_set_keymap("n", "p", "pmt`[v`]=`t", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "P", "Pmt`[v`]=`t", { noremap = true, silent = true })

    vim.api.nvim_set_keymap("v", "p", "pmt`[v`]=`t", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "P", "Pmt`[v`]=`t", { noremap = true, silent = true })

    vim.api.nvim_set_keymap("n", "<leader>p", "\"+pmt`[v`]=`t", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>P", "\"+Pmt`[v`]=`t", { noremap = true, silent = true })

    vim.api.nvim_set_keymap("v", "<leader>p", "\"+pmt`[v`]=`t", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<leader>P", "\"+Pmt`[v`]=`t", { noremap = true, silent = true })
end

local function bind_normal_paste()
    vim.api.nvim_set_keymap("n", "p", "p", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "P", "P", { noremap = true, silent = true })

    vim.api.nvim_set_keymap("v", "p", "p", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "P", "P", { noremap = true, silent = true })

    vim.api.nvim_set_keymap("n", "<leader>p", "\"+p", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>P", "\"+P", { noremap = true, silent = true })

    vim.api.nvim_set_keymap("v", "<leader>p", "\"+p", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<leader>P", "\"+P", { noremap = true, silent = true })
end

local function set_formatting_paste(enabled)
    if enabled then
        bind_formatting_paste()
    else
        bind_normal_paste()
    end
end

local function toggle_formatting_paste()
    vim.g.formatting_paste_enabled = not vim.g.formatting_paste_enabled
    set_formatting_paste(vim.g.formatting_paste_enabled)
end

vim.g.formatting_paste_enabled = true

set_formatting_paste(vim.g.formatting_paste_enabled)

vim.keymap.set("n", "<leader>=", toggle_formatting_paste, { noremap = true, silent = true })

