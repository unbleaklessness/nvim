local LSP = require("lsp-zero")

LSP.on_attach(function(client, buffer_number)
    LSP.default_keymaps({ buffer = buffer_number })
end)

require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "clangd",
        -- "gopls",
        "neocmake",
        "pyright",
        "arduino_language_server",
        "emmet_ls",
        "clojure_lsp",
        -- "glslls",
        "julials",
        "rust_analyzer",
        "matlab_ls",
    },
})

vim.diagnostic.config({
    virtual_text = {
        prefix = "▎",
    },
})

local LSP_config = require("lspconfig")

LSP_config.lua_ls.setup(LSP.nvim_lua_ls())

LSP_config.rust_analyzer.setup({})

LSP_config.neocmake.setup({})

LSP_config.matlab_ls.setup({
    settings = {
        matlab = {
            installPath = "/home/sorokinoleg/MATLAB",
            indexWorkspace = true,
        },
    },
})

require("lazydev").setup()

LSP_config.glslls.setup({
    cmd = { "glslls", "--stdin", "--target-env", "opengl" },
})

-- NeoVim fails to identify the correct file type for the `frag` and `vert` extensions.
vim.cmd([[
    au BufNewFile,BufRead *.frag,*.vert,*.glsl set filetype=glsl
]])

-- NeoVim fails to identify the correct file type for the `urdf` extensions.
vim.cmd([[
    au BufNewFile,BufRead *.urdf set filetype=xml
]])

-- Inline or template implementations for C++.
vim.cmd([[
    au BufNewFile,BufRead *.ipp set filetype=cpp
]])

-- NeoVim fails to identify the correct file type for the `re` extension.
vim.cmd([[
    au BufNewFile,BufRead *.re set filetype=reason
]])

-- NeoVim fails to identify the correct file type for the `rasi` extension.
vim.cmd([[
    au BufNewFile,BufRead *.rasi set filetype=rasi
]])

LSP_config.pyright.setup({
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off",
            },
        },
    },
})

local function file_exists(file_path)
    local file = io.open(file_path, "rb")
    if file then
        file:close()
    end
    return file ~= nil
end

local function read_lines(file_path)
    if not file_exists(file_path) then
        return {}
    end
    local lines = {}
    for line in io.lines(file_path) do
        lines[#lines + 1] = line
    end
    return lines
end

local function trim_string(s)
    return s:gsub("%s+", "")
end

LSP_config.arduino_language_server.setup({
    on_new_config = function(config, _)
        local lines = read_lines(vim.fn.getcwd() .. "/.fqbn")
        local fqbn = "arduino:avr:uno"
        if #lines >= 1 then
            fqbn = trim_string(lines[1])
        end
        require("notify")(string.format("FQBN = %s", fqbn), vim.log.levels.INFO, {
            title = "Arduino Language Server",
            timeout = 5000,
            render = "simple",
        })
        config.cmd = {
            "arduino-language-server",
            "-fqbn",
            fqbn,
        }
    end,
})

LSP_config.tsserver.setup({})

LSP_config.julials.setup({})

LSP_config.clangd.setup({
    cmd = {
        "clangd",
        "--background-index",
        -- "--suggest-missing-includes",
        -- "--clang-tidy",
        -- "--header-insertion=iwyu",
        "--header-insertion=never",
        "--query-driver=**",
        -- '--sysroot "/opt/poky/5.0.1/sysroots/corei7-64-poky-linux"',
    },
})

LSP_config.ocamllsp.setup({
    cmd = { "ocamllsp" },
})

LSP.setup()

vim.cmd([[
    highlight! MyDiagnosticError guifg=#DB4B4B gui=bold
    highlight! MyDiagnosticWarning guifg=#E0AF68 gui=bold
    highlight! MyDiagnosticInfo guifg=#00FFFF gui=bold
    highlight! MyDiagnosticHint guifg=#1ABC9C gui=bold
    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=MyDiagnosticError
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=MyDiagnosticWarning
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=MyDiagnosticInfo
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=MyDiagnosticHint
]])

local CMP = require("cmp")
local CMP_action = LSP.cmp_action()

CMP.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
    mapping = {
        -- Navigate between snippet placeholders.
        ["<C-f>"] = CMP_action.luasnip_jump_forward(),
        ["<C-b>"] = CMP_action.luasnip_jump_backward(),
        -- ['<C-Space>'] = CMP.mapping.complete(),
        -- ['<CR>'] = CMP.mapping.confirm({ select = true }),
        ['<C-y>'] = CMP.mapping.confirm({ select = true }),
        -- ['<C-e>'] = CMP.mapping.abort(),
        ['<C-p>'] = CMP.mapping.select_prev_item({ behavior = 'select' }),
        ['<C-n>'] = CMP.mapping.select_next_item({ behavior = 'select' }),
    },
    snippet = {
        expand = function(arguments)
            require('luasnip').lsp_expand(arguments.body)
        end,
    },
    matching = {
        disallow_fuzzy_matching = false,
        disallow_fullfuzzy_matching = false,
        disallow_partial_fuzzy_matching = false,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = false,
    },
})

vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>lh", ":ClangdSwitchSourceHeader<CR>", { noremap = true, silent = true })
