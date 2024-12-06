require("treesitter-context").setup({
    max_lines = 4,
    on_attach = function(buffer_number)
        return not vim.b.large_buffer
    end,
})
