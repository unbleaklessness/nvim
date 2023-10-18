vim.cmd.colorscheme("tokyonight-night")

-- Make background of inactive buffers darker.
vim.cmd([[
    highlight ActiveBufferBackground guibg=#1A1B26
    highlight ActiveBufferForeground guifg=#1A1B26
    highlight InactiveBufferCursor guibg=#15161E
]])
vim.cmd([[
    highlight Normal guibg=#0D0E12
    highlight EndOfBuffer guifg=#0D0E12
    highlight SignColumn guibg=#0D0E12
    highlight CursorLine guibg=#292E42
]])
vim.cmd([[
    augroup HighlightActiveBufferBackground
        autocmd!
        autocmd WinEnter,BufEnter * setlocal winhighlight=Normal:ActiveBufferBackground,EndOfBuffer:ActiveBufferForeground,SignColumn:ActiveBufferBackground,CursorLine:CursorLine
        autocmd WinLeave,BufLeave * setlocal winhighlight=Normal:Normal,EndOfBuffer:EndOfBuffer,SignColumn:SignColumn,CursorLine:InactiveBufferCursor
    augroup END
]])
