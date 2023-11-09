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

    function s:is_floating(id) abort
        let l:config = nvim_win_get_config(a:id)
        return !empty(l:config.relative) || l:config.external
    endfunction

    function s:my_function()
        if !s:is_floating(win_getid())
            setlocal winhighlight=Normal:ActiveBufferBG
            setlocal winhighlight+=EndOfBuffer:ActiveBufferFG
            setlocal winhighlight+=SignColumn:ActiveBufferBG
            setlocal winhighlight+=CursorLine:ActiveBufferCursorLine
            setlocal winhighlight+=ColorColumn:ActiveBufferColorColumn
        endif
    endfunction

    function s:reset_winhighlight()
        if !s:is_floating(win_getid())
            setlocal winhighlight=Normal:InactiveBufferBG
            setlocal winhighlight+=EndOfBuffer:InactiveBufferFG
            setlocal winhighlight+=SignColumn:InactiveBufferBG
            setlocal winhighlight+=CursorLine:InactiveBufferCursorLine
            setlocal winhighlight+=ColorColumn:InactiveBufferColorColumn
        endif
    endfunction

    augroup ExcludeBuffers
        autocmd!
        autocmd WinEnter,BufEnter * call s:my_function()
        autocmd WinLeave,BufLeave * call s:reset_winhighlight()
    augroup END
]])
