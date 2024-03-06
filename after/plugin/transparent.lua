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

        -- CMake Tools.
        "NormalSB",
        "SignColumnSB",

        -- NVim Notify.
        "NotifyERRORBody",
        "NotifyWARNBody",
        "NotifyINFOBody",
        "NotifyDEBUGBody",
        "NotifyTRACEBody",
        "NotifyERRORBorder",
        "NotifyWARNBorder",
        "NotifyINFOBorder",
        "NotifyDEBUGBorder",
        "NotifyTRACEBorder",
        "NotifyERRORIcon",
        "NotifyWARNIcon",
        "NotifyINFOIcon",
        "NotifyDEBUGIcon",
        "NotifyTRACEIcon",
        "NotifyERRORTitle",
        "NotifyWARNTitle",
        "NotifyINFOTitle",
        "NotifyDEBUGTitle",
        "NotifyTRACETitle",
    },
    exclude_groups = {},
})

vim.cmd(":TransparentEnable")
