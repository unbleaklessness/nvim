local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end

local lua_line = require("lualine")

local function getWords()
    if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "" then
        return vim.fn.wordcount().visual_words .. " words"
    else
        return vim.fn.wordcount().words .. " words"
    end
end

lua_line.setup({
    options = {
        -- theme = "tokyonight",
        -- theme = "gruvbox-material",
        theme = "catppuccin",
        disabled_filetypes = {
            "NvimTree",
            "dapui_console",
            "dap-repl",
            "dapui_scopes",
            "dapui_breakpoints",
            "dapui_stacks",
            "dapui_watches",
            "spectre_panel",
            "qf",
        },
    },
    sections = {
        lualine_b = {
            {
                "macro-recording",
                fmt = show_macro_recording,
                color = { fg = "#ff9e64" },
            },
        },
        lualine_c = {
            {
                "filename",
                path = 0,
            },
            {
                "filename",
                path = 1,
            },
        },
        lualine_x = {
            { getWords },
            "encoding",
            "filetype",
        },
    },
})

vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
        lua_line.refresh({
            place = { "statusline" },
        })
    end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
        local timer = vim.loop.new_timer()
        timer:start(
            50,
            0,
            vim.schedule_wrap(function()
                lua_line.refresh({
                    place = { "statusline" },
                })
            end)
        )
    end,
})
