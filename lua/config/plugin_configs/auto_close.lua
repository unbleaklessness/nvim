require("autoclose").setup({
    options = {
        disable_command_mode = true,
        disable_when_touch = true,
        pair_spaces = true,
        disabled_filetypes = {
            "TelescopePrompt",
            "chatgpt-input",
            "off",
        },
    },
})
