vim.api.nvim_set_keymap("n", "<leader>tw", ":silent !kitty --single-instance<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>Dt", ":difft<CR>", { noremap = true, silent = true }) -- Diff this.
vim.api.nvim_set_keymap("n", "<leader>Do", ":diffo!<CR>", { noremap = true, silent = true }) -- Off.
vim.api.nvim_set_keymap("n", "<leader>Dg", ":diffg<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>Dg", ":diffg<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>qc", ":cclose<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>qo", ":copen<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>qn", ":cnext<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>qp", ":cprevious<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>h", ":noh<CR>", { noremap = true, silent = true })

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

vim.api.nvim_set_keymap("n", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Y", '"+Y', { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>Y", '"+Y', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap("n", "<leader>d", '"+d', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>D", '"+D', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap("v", "<leader>d", '"+d', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<leader>D", '"+D', { noremap = true, silent = true })

local function bind_formatting_paste()
    vim.api.nvim_set_keymap("n", "p", "pmt`[v`]=`t", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "P", "Pmt`[v`]=`t", { noremap = true, silent = true })

    vim.api.nvim_set_keymap("v", "p", "pmt`[v`]=`t", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "P", "Pmt`[v`]=`t", { noremap = true, silent = true })

    vim.api.nvim_set_keymap("n", "<leader>p", '"+pmt`[v`]=`t', { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>P", '"+Pmt`[v`]=`t', { noremap = true, silent = true })

    vim.api.nvim_set_keymap("v", "<leader>p", '"+pmt`[v`]=`t', { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<leader>P", '"+Pmt`[v`]=`t', { noremap = true, silent = true })
end

local function bind_normal_paste()
    vim.api.nvim_set_keymap("n", "p", "p", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "P", "P", { noremap = true, silent = true })

    vim.api.nvim_set_keymap("v", "p", "p", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "P", "P", { noremap = true, silent = true })

    vim.api.nvim_set_keymap("n", "<leader>p", '"+p', { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>P", '"+P', { noremap = true, silent = true })

    vim.api.nvim_set_keymap("v", "<leader>p", '"+p', { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<leader>P", '"+P', { noremap = true, silent = true })
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

local function switch_case()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local word = vim.fn.expand("<cword>")
    local word_start = vim.fn.matchstrpos(vim.fn.getline("."), "\\k*\\%" .. (col + 1) .. "c\\k*")[2]

    -- Detect camelCase.
    if word:find("[a-z][A-Z]") then
        -- Convert camelCase to snake_case.
        local snake_case_word = word:gsub("([a-z])([A-Z])", "%1_%2"):lower()
        vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { snake_case_word })
    -- Detect snake_case
    elseif word:find("_[a-z]") then
        -- Convert snake_case to camelCase.
        local camel_case_word = word:gsub("(_)([a-z])", function(_, l)
            return l:upper()
        end)
        vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { camel_case_word })
    else
        print("Not a snake_case or camelCase word!")
    end
end

vim.keymap.set("n", "<leader>S", switch_case, { noremap = true, silent = true })
