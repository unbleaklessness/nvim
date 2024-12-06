function Select_inside_code_fence()
    local start_line, end_line
    local current_line = vim.fn.line('.')
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    for i = current_line, 1, -1 do
        if lines[i]:match("^```") then
            start_line = i + 1
            break
        end
    end

    for i = current_line + 1, #lines do
        if lines[i]:match("^```") then
            end_line = i - 1
            break
        end
    end

    if start_line and end_line and current_line <= start_line and current_line <= end_line then
        vim.fn.setpos("'<", { 0, start_line, 1, 0 })
        vim.fn.setpos("'>", { 0, end_line + 1, 1, 0 })
        vim.cmd('normal! gv')
    end
end

vim.api.nvim_set_keymap('x', 'i~', ':lua Select_inside_code_fence()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('o', 'i~', ':<C-U>lua Select_inside_code_fence()<CR>', { noremap = true, silent = true })
