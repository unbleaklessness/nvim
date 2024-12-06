LARGE_BUFFER_SIZE = 100000
LARGE_BUFFER_LINE_WIDTH = 400

local large_buffer = function()
    vim.bo.syntax = "off"
    vim.bo.filetype = "off"

    -- vim.opt_local.foldmethod = "manual"
    -- vim.opt_local.spell = false
    -- vim.opt_local.undofile = false
    -- vim.opt_local.undolevels = 0
    -- vim.opt_local.autoread = false

    local buffer_number = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_active_clients({ bufnr = buffer_number })
    for _, client in ipairs(clients) do
        vim.lsp.stop_client(client.id)
    end
end

vim.api.nvim_create_user_command("LargeBuffer", large_buffer, {})

vim.api.nvim_create_augroup("LargeBuffer", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufReadPost", "FileReadPre", "FileReadPost", "BufWinEnter", "BufEnter" }, {
    callback = function()
        vim.b.large_buffer = false

        local buffer_number = vim.api.nvim_get_current_buf()
        local buffer_name = vim.api.nvim_buf_get_name(buffer_number)
        local ok, stats = pcall(vim.loop.fs_stat, buffer_name)

        local long_lines = false
        local lines = vim.api.nvim_buf_get_lines(buffer_number, 0, -1, false)
        for _, line in ipairs(lines) do
            if #line > LARGE_BUFFER_LINE_WIDTH then
                long_lines = true
                break
            end
        end

        if ok and stats and (stats.size > LARGE_BUFFER_SIZE or long_lines) then
            vim.b.large_buffer = true
            large_buffer()
        end
    end,
    pattern = "*",
    group = "LargeBuffer",
})

return {
    LARGE_BUFFER_SIZE = LARGE_BUFFER_SIZE,
    LARGE_BUFFER_LINE_WIDTH = LARGE_BUFFER_LINE_WIDTH,
}
