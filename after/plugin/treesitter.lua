local function disable_function(language, buffer_number)
    return vim.fn.getfsize(vim.api.nvim_buf_get_name(buffer_number)) > 50000
end

require'nvim-treesitter.configs'.setup {
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
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'org' },
        disable = disable_function,
    },
}
