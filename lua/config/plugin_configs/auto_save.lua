require("auto-save").setup({
    -- execution_message = {
    --     message = function()
    --         return ""
    --     end,
    -- },
    condition = function(_ --[[ Buffer. ]])
        return not vim.b.large_buffer
    end,
    lockmarks = true, -- Keep the '[ and the '] marks.
})
