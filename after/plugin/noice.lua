require("noice").setup({
    cmdline = {
        format = {
            cmdline = {
                title = " Command Line ",
            },
        },
    },
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
    },
    messages = {
        view = "mini",
    },
    routes = {
        { -- Ignore `toggleterm` errors from `cmake-tools` plugin.
            filter = {
                event = "msg_show",
                kind = "",
                find = "start/toggleterm.nvim/lua/toggleterm/terminal.lua:374",
            },
            opts = { skip = true },
        },
    },
})
