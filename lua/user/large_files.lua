local group = vim.api.nvim_create_augroup("large_buffers", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre" }, {
    callback = function()
        local buffer_number = vim.api.nvim_get_current_buf()
        local buffer_name = vim.api.nvim_buf_get_name(buffer_number)
        local extension = vim.fn.expand('%:e')
        local ok, stats = pcall(vim.loop.fs_stat, buffer_name)
        if ok and stats and stats.size > 75000 and extension == "cpp" then
            vim.cmd [[ syntax off ]]
        end
    end,
    group = group,
    pattern = "*",
})
