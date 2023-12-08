-- Aligns to 1 character.
vim.keymap.set('x', 'aa', function()
    require'align'.align_to_char({
        length = 1,
    })
end, { noremap = true, silent = true })
