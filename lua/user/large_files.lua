local group = vim.api.nvim_create_augroup("large_buffers", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre" }, {
    callback = function()
        local buffer_number = vim.api.nvim_get_current_buf()
        local buffer_name = vim.api.nvim_buf_get_name(buffer_number)
        local ok, stats = pcall(vim.loop.fs_stat, buffer_name)
        if ok and stats and stats.size > 50000 then
            vim.cmd [[ syntax off ]]
            vim.cmd [[ IBLDisable ]]
            vim.cmd [[ TSContextDisable ]]
        end
    end,
    group = group,
    pattern = "*",
})
