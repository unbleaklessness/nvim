local function disable_function(_, _ --[[ Buffer number. ]])
    return vim.b.large_buffer
end

local ensure_installed = {
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
    -- "reason",
    "regex",
    "markdown",
    "markdown_inline",
    "doxygen",
}

--- @diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
    ensure_installed = ensure_installed,
    sync_install = true,
    auto_install = false,
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
