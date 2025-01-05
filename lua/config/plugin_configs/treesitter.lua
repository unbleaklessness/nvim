local function disable_function(_, _ --[[ Buffer number. ]])
    return vim.b.large_buffer
end

--- @diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "javascript",
        "typescript",
        "rust",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "python",
        "bash",
        "reason",
        "regex",
        "markdown",
        "markdown_inline",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "org" },
        disable = { disable_function, 'dockerfile' },
    },
    indent = {
        enable = true,
        disable = disable_function,
    },
})
