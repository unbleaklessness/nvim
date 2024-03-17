require("mason").setup()

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'lua_ls',
    'clangd',
    'gopls',
    'neocmake',
    'pyright',
    'arduino_language_server',
    'emmet_ls',
})

vim.diagnostic.config({
    virtual_text = {
        prefix = '▎',
    }
})

require('neodev').setup()

local lsp_config = require'lspconfig'

lsp_config.lua_ls.setup(lsp.nvim_lua_ls())

lsp_config.glslls.setup{
    cmd = { "glslls", "--stdin", "--target-env", "opengl" }
}
-- NeoVim fails to identify the correct file type for the `frag` and `vert` extensions.
vim.cmd [[
    au BufNewFile,BufRead *.frag,*.vert,*.glsl set filetype=glsl
]]

-- NeoVim fails to identify the correct file type for the `re` extension.
vim.cmd [[
    au BufNewFile,BufRead *.re set filetype=reason
]]

-- NeoVim fails to identify the correct file type for the `rasi` extension.
vim.cmd [[
    au BufNewFile,BufRead *.rasi set filetype=rasi
]]

lsp_config.pyright.setup {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = 'off',
            },
        },
    },
}

local function file_exists(file_path)
    local file = io.open(file_path, "rb")
    if file then file:close() end
    return file ~= nil
end

local function read_lines(file_path)
    if not file_exists(file_path) then return {} end
    local lines = {}
    for line in io.lines(file_path) do
        lines[#lines + 1] = line
    end
    return lines
end

local function trim_string(s)
    return s:gsub("%s+", "")
end

lsp_config.arduino_language_server.setup {
    on_new_config = function(config, _)
        local lines = read_lines(vim.fn.getcwd() .. '/.fqbn')
        local fqbn = 'arduino:avr:uno'
        if #lines >= 1 then
            fqbn = trim_string(lines[1])
        end
        require('notify')(('FQBN = %s'):format(fqbn), vim.log.levels.INFO, {
            title = 'Arduino Language Server',
            timeout = 5000,
            render = 'simple',
        })
        config.cmd = {
            'arduino-language-server',
            '-fqbn', fqbn
        }
    end
}

lsp_config.tsserver.setup {}

lsp_config.clangd.setup {
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },
}

lsp_config.ocamllsp.setup {
    cmd = { "ocamllsp" },
}

lsp.on_attach(function(_, buffer_number)
    lsp.default_keymaps({buffer = buffer_number})
    local options = {buffer = buffer_number}
    vim.keymap.set({'n', 'x'}, '<space>lf', function()
        vim.lsp.buf.format({async = false, timeout_ms = 10000})
    end, options)
end)

lsp.setup()

vim.cmd [[
    highlight! MyDiagnosticError guifg=#DB4B4B gui=bold
    highlight! MyDiagnosticWarning guifg=#E0AF68 gui=bold
    highlight! MyDiagnosticInfo guifg=#00FFFF gui=bold
    highlight! MyDiagnosticHint guifg=#1ABC9C gui=bold
    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=MyDiagnosticError
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=MyDiagnosticWarning
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=MyDiagnosticInfo
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=MyDiagnosticHint
]]

local cmp = require('cmp')
local cmp_action = lsp.cmp_action()

cmp.setup({
    mapping = {
        -- Navigate between snippet placeholders.
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    },
})

vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { noremap = true, silent = true })

