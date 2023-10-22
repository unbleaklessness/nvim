require('lualine').setup({
    options = {
        disabled_filetypes = {
            'NvimTree',
            'dapui_console',
            'dap-repl',
            'dapui_scopes',
            'dapui_breakpoints',
            'dapui_stacks',
            'dapui_watches',
        },
    },
})
