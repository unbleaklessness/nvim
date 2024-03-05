require("transparent").setup({
    extra_groups = {
        "NormalFloat",
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "NvimTreeWinSeparator",
    },
})

vim.cmd(":TransparentEnable")
