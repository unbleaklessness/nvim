LARGE_FILE_SIZE = 75000

local large_buffer = function()
    vim.bo.syntax = "off"
    vim.bo.filetype = "off"
end

vim.api.nvim_create_user_command("LargeFile", large_buffer, {})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufReadPost" }, {
    callback = function()
        local buffer_number = vim.api.nvim_get_current_buf()
        local buffer_name = vim.api.nvim_buf_get_name(buffer_number)
        -- local extension = vim.fn.expand('%:e')
        local ok, stats = pcall(vim.loop.fs_stat, buffer_name)
        if ok and stats and stats.size > LARGE_FILE_SIZE then
            large_buffer()
        end
    end,
    pattern = "*",
})

return {
    LARGE_FILE_SIZE = LARGE_FILE_SIZE,
}
