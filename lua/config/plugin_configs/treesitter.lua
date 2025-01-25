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

vim.api.nvim_create_user_command("TSInstallAll", function()
    for _, v in ipairs(ensure_installed) do
        vim.cmd("TSInstallSync " .. v)
    end
end, {})
