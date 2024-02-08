local group = vim.api.nvim_create_augroup("large_buffers", { clear = true })

-- LARGE_FILE_SIZE = 75000
LARGE_FILE_SIZE = 1000000

vim.api.nvim_create_autocmd({ "BufReadPre" }, {
    callback = function()
        local buffer_number = vim.api.nvim_get_current_buf()
        local buffer_name = vim.api.nvim_buf_get_name(buffer_number)
        local extension = vim.fn.expand('%:e')
        local ok, stats = pcall(vim.loop.fs_stat, buffer_name)
        if ok and stats and stats.size > LARGE_FILE_SIZE and extension == "cpp" then
            vim.cmd [[ syntax off ]]
        end
    end,
    group = group,
    pattern = "*",
})

return {
    LARGE_FILE_SIZE = LARGE_FILE_SIZE,
}
