local rainbow_delimiters = require("rainbow-delimiters")

vim.g.rainbow_delimiters = {
    strategy = {
        [""] = function(buffer_number)
            if vim.b.large_buffer then
                return nil
            else
                return rainbow_delimiters.strategy["global"]
            end
        end,
        vim = function(buffer_number)
            if vim.b.large_buffer then
                return nil
            else
                return rainbow_delimiters.strategy["local"]
            end
        end,
    },
    query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
    },
    priority = {
        -- These priorities do not work with the `treesitter-context`.
        -- [""] = 110,
        -- lua = 210,

        -- These priorities work nicely with the `treesitter-context`.
        [""] = 210,
        lua = 410,
    },
    highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
    },
}
