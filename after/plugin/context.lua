require'treesitter-context'.setup{
    max_lines = 4,
    on_attach = function(buffer_number)
        local buffer_name = vim.api.nvim_buf_get_name(buffer_number)
        local extension = vim.fn.expand('%:e')
        local ok, stats = pcall(vim.loop.fs_stat, buffer_name)
        if ok and stats and stats.size > 75000 and extension == "cpp" then
            return false
        end
        return true
    end
}
