require("tokyonight").setup({
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
    },
})

vim.cmd.colorscheme("tokyonight-night")

-- Make background of inactive buffers darker.
vim.cmd([[
    highlight ActiveBufferBG guibg=#1A1B26
    highlight ActiveBufferFG guifg=#1A1B26
    highlight ActiveBufferCursorLine guibg=#292E42
    highlight ActiveBufferColorColumn guibg=#15161E
]])
vim.cmd([[
    highlight InactiveBufferBG guibg=#010101
    highlight InactiveBufferFG guifg=#010101
    highlight InactiveBufferCursorLine guibg=#292E42
    highlight InactiveBufferColorColumn guibg=#15161E
]])
vim.cmd([[
    augroup HighlightActiveBufferBG
        autocmd!
        autocmd WinEnter,BufEnter * setlocal winhighlight=Normal:ActiveBufferBG,EndOfBuffer:ActiveBufferFG,SignColumn:ActiveBufferBG,CursorLine:ActiveBufferCursorLine,ColorColumn:ActiveBufferColorColumn
        autocmd WinLeave,BufLeave * setlocal winhighlight=Normal:InactiveBufferBG,EndOfBuffer:InactiveBufferFG,SignColumn:InactiveBufferBG,CursorLine:InactiveBufferCursorLine,ColorColumn:InactiveBufferColorColumn
    augroup END
]])
