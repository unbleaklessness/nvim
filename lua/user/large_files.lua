LARGE_FILE_SIZE = 75000

vim.api.nvim_create_autocmd({ "BufReadPre", "BufReadPost" }, {
    callback = function()
        local buffer_number = vim.api.nvim_get_current_buf()
        local buffer_name = vim.api.nvim_buf_get_name(buffer_number)
        -- local extension = vim.fn.expand('%:e')
        local ok, stats = pcall(vim.loop.fs_stat, buffer_name)
        if ok and stats and stats.size > LARGE_FILE_SIZE then
            vim.bo.syntax = "off"
            vim.bo.filetype = "off"
        else
        end
    end,
    pattern = "*",
})

return {
    LARGE_FILE_SIZE = LARGE_FILE_SIZE,
}
