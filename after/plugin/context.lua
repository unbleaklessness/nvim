require'treesitter-context'.setup{
    max_lines = 4,
    on_attach = function(buffer_number)
        local buffer_name = vim.api.nvim_buf_get_name(buffer_number)
        local ok, stats = pcall(vim.loop.fs_stat, buffer_name)
        if ok and stats and stats.size > 50000 then
            return false
        end
        return true
    end
}
