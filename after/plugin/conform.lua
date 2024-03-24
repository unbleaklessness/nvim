local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        glsl = { "clang_format" },
        lua = { "stylua" },
        cmake = { "gersemi" },
    },
})

vim.api.nvim_create_user_command("ConformFormat", function(arguments)
    local range = nil
    if arguments.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, arguments.line2 - 1, arguments.line2, true)[1]
        range = {
            start = { arguments.line1, 0 },
            ["end"] = { arguments.line2, end_line:len() },
        }
    end
    conform.format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

vim.api.nvim_set_keymap("n", "<space>lf", ":ConformFormat<CR>", { noremap = true, silent = true })
