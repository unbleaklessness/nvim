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
        { -- Ignore 'File written' messages.
            filter = {
                event = "msg_show",
                kind = "",
                find = "written",
            },
            opts = { skip = true },
        },
        { -- Ignore 'Indented' messages.
            filter = {
                event = "msg_show",
                kind = "",
                find = "indented",
            },
            opts = { skip = true },
        },
        { -- Ignore 'Yanked' messages.
            filter = {
                event = "msg_show",
                kind = "",
                find = "yanked",
            },
            opts = { skip = true },
        },
        { -- Ignore 'Fewer' messages.
            filter = {
                event = "msg_show",
                kind = "",
                find = "fewer",
            },
            opts = { skip = true },
        },
        { -- Ignore 'More' messages.
            filter = {
                event = "msg_show",
                kind = "",
                find = "more",
            },
            opts = { skip = true },
        },
        { -- Ignore search count messages.
            filter = {
                event = "msg_show",
                kind = "search_count",
            },
            opts = { skip = true },
        },
    },
})
