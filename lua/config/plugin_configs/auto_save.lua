require("auto-save").setup({
    condition = function(_ --[[ Buffer. ]])
        return not vim.b.large_buffer
    end,
    lockmarks = true, -- Keep the '[ and the '] marks.
})
