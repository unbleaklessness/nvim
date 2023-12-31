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

require'lspconfig'.lua_ls.setup(lsp.nvim_lua_ls())

require'lspconfig'.glslls.setup{
    cmd = { "glslls", "--stdin", "--target-env", "opengl" }
}
-- NeoVim fails to identify the correct type for `frag` and `vert` extensions.
vim.cmd [[
    au BufNewFile,BufRead *.frag,*.vert,*.glsl set filetype=glsl
]]

require'lspconfig'.pyright.setup {
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

require'lspconfig'.arduino_language_server.setup {
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

require'lspconfig'.tsserver.setup {}

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

