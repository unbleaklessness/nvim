-- LARGE_FILE_SIZE = 75000
LARGE_FILE_SIZE = 100000
-- LARGE_FILE_SIZE = 35000
-- LARGE_FILE_SIZE = 10000
-- LARGE_FILE_SIZE = 1
-- LARGE_FILE_SIZE = 100
-- LARGE_FILE_SIZE = 150000
-- LARGE_FILE_SIZE = 9999999

local large_file = function()
    vim.bo.syntax = "off"
    vim.bo.filetype = "off"
end

vim.api.nvim_create_user_command("LargeFile", large_file, {})

vim.api.nvim_create_augroup("LargeFile", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufReadPost", "FileReadPre", "FileReadPost", "BufWinEnter", "BufEnter" }, {
    callback = function()
        local buffer_number = vim.api.nvim_get_current_buf()
        local buffer_name = vim.api.nvim_buf_get_name(buffer_number)
        local ok, stats = pcall(vim.loop.fs_stat, buffer_name)
        if ok and stats and stats.size > LARGE_FILE_SIZE then
            large_file()
        end
    end,
    pattern = "*",
    group = "LargeFile",
})

return {
    LARGE_FILE_SIZE = LARGE_FILE_SIZE,
}
