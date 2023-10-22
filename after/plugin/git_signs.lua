require('gitsigns').setup({
    on_attach = function(buffer)

        local git_signs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, options)
            options = options or {}
            options.buffer = buffer
            vim.keymap.set(mode, lhs, rhs, options)
        end

        map('n', ']c', function()
            if vim.wo.diff then
                return ']c'
            end
            vim.schedule(function() git_signs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
            if vim.wo.diff then
                return '[c'
            end
            vim.schedule(function() git_signs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '<leader>gp', git_signs.preview_hunk_inline)
        map('n', '<leader>gs', git_signs.stage_hunk)
        map('n', '<leader>gS', git_signs.stage_buffer)
        map('n', '<leader>gr', git_signs.reset_hunk)
        map('n', '<leader>gR', git_signs.reset_buffer)
        map('n', '<leader>gu', git_signs.undo_stage_hunk)
        map('n', '<leader>gd', git_signs.diffthis)
    end
})
