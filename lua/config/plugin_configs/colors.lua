-- --- @diagnostic disable-next-line: missing-fields
-- require("tokyonight").setup({
--     -- transparent = vim.g.transparent_enabled,
--     styles = {
--         comments = { italic = false },
--         keywords = { italic = false },
--     },
-- })

-- vim.cmd.colorscheme("tokyonight-night")

-- vim.cmd.colorscheme("gruvbox-material")

require("catppuccin").setup({
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
    },
})
vim.cmd.colorscheme("catppuccin")

-- Make background of inactive buffers darker.

if true then
    vim.cmd([[

        " For Tokyo Night theme.

        " highlight ActiveBufferBG guibg=#1A1B26
        " highlight ActiveBufferFG guifg=#1A1B26

        " For Gruvbox Material theme.

        " highlight ActiveBufferBG guibg=#282828
        " highlight ActiveBufferFG guifg=#282828

        " For Catppuccin theme.

        highlight ActiveBufferBG guibg=#1e1e2e
        highlight ActiveBufferFG guifg=#1e1e2e
    ]])

    vim.cmd([[

        " For Tokyo Night theme.

        " highlight InactiveBufferBG guibg=#010101
        " highlight InactiveBufferFG guifg=#010101

        " For Gruvbox Material theme.

        " highlight InactiveBufferBG guibg=#010101
        " highlight InactiveBufferFG guifg=#010101

        " For Catppuccin theme.

        highlight InactiveBufferBG guibg=#010101
        highlight InactiveBufferFG guifg=#010101
    ]])

    vim.cmd([[
        function s:is_floating(id) abort
            let l:config = nvim_win_get_config(a:id)
            return !empty(l:config.relative) || l:config.external
        endfunction

        function s:highlight_active()
            if !s:is_floating(win_getid())
                setlocal winhighlight=Normal:ActiveBufferBG
                setlocal winhighlight+=EndOfBuffer:ActiveBufferFG
                setlocal winhighlight+=SignColumn:ActiveBufferBG
            endif
        endfunction

        function s:highlight_inactive()
            if !s:is_floating(win_getid())
                setlocal winhighlight=Normal:InactiveBufferBG
                setlocal winhighlight+=EndOfBuffer:InactiveBufferFG
                setlocal winhighlight+=SignColumn:InactiveBufferBG
            endif
        endfunction

        augroup highlight_inactive
            autocmd!
            autocmd WinEnter,BufEnter * call s:highlight_active()
            autocmd WinLeave,BufLeave * call s:highlight_inactive()
        augroup END
    ]])
end

-- Highlight matched characters inside Telescope with the red color.
vim.cmd([[
    highlight TelescopeMatching guifg=#ff0000
]])
