require("transparent").setup({
    groups = {
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
        'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
        'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
        'EndOfBuffer',
    },
    extra_groups = {
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "NvimTreeWinSeparator",

        "TelescopeBorder",
        "TelescopeNormal",

        -- ChatGPT...
        "ChatGPTSelectedMessage",
        "FoldColumn",
        "NormalFloat",
        "FloatBorder",
        "FloatTitle",
    },
    exclude_groups = {},
})

vim.cmd(":TransparentEnable")
