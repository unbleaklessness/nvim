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
    sections = {
        lualine_c = {
            {
                'filename',
                path = 0,
            },
            {
                'filename',
                path = 1,
            }
        },
        lualine_x = {'encoding', 'filetype'}
    },
})
