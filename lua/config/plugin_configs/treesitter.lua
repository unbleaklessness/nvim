local large_files = require("config.large_files")

local function disable_function(_, buffer_number)
    local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(buffer_number))
    return size > large_files.LARGE_FILE_SIZE
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
        disable = disable_function,
    },
    indent = {
        enable = true,
        disable = disable_function,
    },
})
