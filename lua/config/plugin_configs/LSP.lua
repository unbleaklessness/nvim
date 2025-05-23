-- local LSP = require("lsp-zero")

-- LSP.on_attach(function(_ --[[ Client. ]], buffer_number)
--     LSP.default_keymaps({ buffer = buffer_number })
-- end)

require("mason").setup()

-- LSPs only.
local ensure_installed = {
    "matlab_ls@97d43dbed952c3b0b095522d422b227abb27cf0b",
    "lua_ls@3.13.5",
    "clangd@19.1.2",
    -- "fixjson",
    -- "gopls",
    -- "neocmake",
    "pyright@1.1.392",
    "arduino_language_server@0.7.6",
    "emmet_ls@0.4.2",
    "clojure_lsp@2025.01.22-23.28.23",
    -- "glslls",
    "julials@v1.127.2",
    "rust_analyzer@2025-01-20",
    "bashls@5.4.3",
}

-- LSPs + everything else.
local all_ensure_installed = {
    "clang-format@19.1.7",
    "jq@jq-1.7",
    "beautysh@386e46cf6e6e68e26e90a6c0e8c3d0f0d30c101c",
    "black@24.10.0",
    "xmlformatter@0.2.8",
    "gersemi@0.18.2",
    "stylua@v2.0.2",
}

for _, v in ipairs(ensure_installed) do
    table.insert(all_ensure_installed, v)
end

--- @diagnostic disable-next-line: missing-fields
require("mason-lspconfig").setup({ ensure_installed = ensure_installed })

vim.api.nvim_create_user_command("MasonInstallAll", function()
    local mappings = require("mason-lspconfig.mappings.server")
    local to_package = mappings.lspconfig_to_package

    local packages_to_install = {}
    for _, entry in ipairs(all_ensure_installed) do
        if string.find(entry, '@') then -- Version is specified.
            local name = entry:match("^(.-)@")
            local version = entry:match("@(.+)$")
            local package_name = to_package[name]
            if package_name then
                table.insert(packages_to_install, package_name .. "@" .. version)
            else
                table.insert(packages_to_install, entry)
            end
        else
            local package_name = to_package[entry] or entry
            table.insert(packages_to_install, package_name)
        end
    end

    for _, p in ipairs(packages_to_install) do
        vim.cmd("MasonInstall " .. p)
        vim.notify("Installed package: " .. p, vim.log.levels.INFO)
    end
end, {
    desc = "Install all packages specified in the config, handling LSP server mappings.",
})

vim.diagnostic.config({
    virtual_text = {
        prefix = "▎",
    },
})

local LSP_config = require("lspconfig")

-- local border = {
--     { "🭽", "FloatBorder" },
--     { "▔", "FloatBorder" },
--     { "🭾", "FloatBorder" },
--     { "▕", "FloatBorder" },
--     { "🭿", "FloatBorder" },
--     { "▁", "FloatBorder" },
--     { "🭼", "FloatBorder" },
--     { "▏", "FloatBorder" },
-- }

local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}

local original_open_floating_preview = vim.lsp.util.open_floating_preview
--- @diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, options, ...)
    options = options or {}
    options.border = options.border or border
    return original_open_floating_preview(contents, syntax, options, ...)
end

local LSP_config_defaults = LSP_config.util.default_config
LSP_config_defaults.capabilities =
    vim.tbl_deep_extend("force", LSP_config_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local options = { buffer = event.buf }
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", options)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", options)
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", options)
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", options)
        vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", options)
        -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", options)
        vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", options)
    end,
})

-- LSP_config.lua_ls.setup(LSP.nvim_lua_ls())
LSP_config.lua_ls.setup({})

LSP_config.bashls.setup({})

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

-- local function file_exists(file_path)
--     local file = io.open(file_path, "rb")
--     if file then
--         file:close()
--     end
--     return file ~= nil
-- end

-- local function read_lines(file_path)
--     if not file_exists(file_path) then
--         return {}
--     end
--     local lines = {}
--     for line in io.lines(file_path) do
--         lines[#lines + 1] = line
--     end
--     return lines
-- end

-- local function trim_string(s)
--     return s:gsub("%s+", "")
-- end

-- LSP_config.arduino_language_server.setup({
--     on_new_config = function(config, _)
--         local lines = read_lines(vim.fn.getcwd() .. "/.fqbn")
--         local fqbn = "arduino:avr:uno"
--         if #lines >= 1 then
--             fqbn = trim_string(lines[1])
--         end
--         require("notify")(string.format("FQBN = %s", fqbn), vim.log.levels.INFO, {
--             title = "Arduino Language Server",
--             timeout = 5000,
--             render = "simple",
--         })
--         config.cmd = {
--             "arduino-language-server",
--             "-fqbn",
--             fqbn,
--         }
--     end,
-- })

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

-- LSP.setup()

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
local Lua_snip = require("luasnip")
-- local CMP_action = LSP.cmp_action()

CMP.setup({
    sources = {
        { name = "lazydev", group_index = 0 },
        -- { name = 'nvim_lsp_signature_help' },
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
    window = {
        completion = CMP.config.window.bordered(),
        documentation = CMP.config.window.bordered(),
    },
    mapping = {
        -- Navigate between snippet placeholders.
        -- ["<C-l>"] = CMP_action.luasnip_jump_forward(),
        -- ["<C-h>"] = CMP_action.luasnip_jump_backward(),
        ["<C-l>"] = CMP.mapping(function(fallback)
            if CMP.visible() then
                CMP.select_next_item()
            elseif Lua_snip.locally_jumpable(1) then
                Lua_snip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-h>"] = CMP.mapping(function(fallback)
            if CMP.visible() then
                CMP.select_prev_item()
            elseif Lua_snip.locally_jumpable(-1) then
                Lua_snip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        -- ['<C-Space>'] = CMP.mapping.complete(),
        -- ['<CR>'] = CMP.mapping.confirm({ select = true }),
        -- ['<C-j>'] = CMP.mapping.confirm({ select = true }),
        ["<C-j>"] = CMP.mapping(function(fallback)
            if CMP.visible() then
                if Lua_snip.expandable() then
                    Lua_snip.expand()
                else
                    CMP.confirm({
                        select = true,
                    })
                end
            else
                fallback()
            end
        end),
        -- ['<C-k>'] = CMP.mapping.confirm({ select = true }),
        -- ['<C-e>'] = CMP.mapping.abort(),
        ["<C-k>"] = CMP.mapping.abort(),
        ["<C-p>"] = CMP.mapping.select_prev_item({ behavior = "select" }),
        ["<C-n>"] = CMP.mapping.select_next_item({ behavior = "select" }),
    },
    snippet = {
        expand = function(arguments)
            Lua_snip.lsp_expand(arguments.body)
        end,
    },
    matching = {
        disallow_fuzzy_matching = false,
        disallow_fullfuzzy_matching = false,
        disallow_partial_fuzzy_matching = false,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = false,
        disallow_symbol_nonprefix_matching = true,
    },
})

vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { noremap = true, silent = true })

-- vim.api.nvim_set_keymap("n", "<leader>lh", ":ClangdSwitchSourceHeader<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gh", ":ClangdSwitchSourceHeader<CR>", { noremap = true, silent = true })
