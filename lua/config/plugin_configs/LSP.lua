-- local LSP = require("lsp-zero")

-- LSP.on_attach(function(_ --[[ Client. ]], buffer_number)
--     LSP.default_keymaps({ buffer = buffer_number })
-- end)

-- Load user-defined LSP servers
local user_lsp_servers = {}
local ok, result = pcall(require, "config.user_lsp_servers")
if ok and type(result) == "table" and #result > 0 then
    user_lsp_servers = result
else
    -- Default to lua_ls if user config is missing, empty, or invalid
    vim.notify("LSP: user_lsp_servers.lua not found or empty, defaulting to lua_ls.", vim.log.levels.WARN, { title = "LSP Configuration" })
    user_lsp_servers = { "lua_ls" }
end

require("mason").setup()

-- Use user_lsp_servers for mason-lspconfig
require("mason-lspconfig").setup({ ensure_installed = user_lsp_servers })

vim.api.nvim_create_user_command("MasonInstallAll", function()
    vim.cmd("MasonInstall " .. table.concat(user_lsp_servers, " "))
end, {})

-- Helper functions (needed for arduino_language_server)
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
    return s:gsub("^%s*(.-)%s*$", "%1") -- More robust trim
end

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
LSP_config_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    LSP_config_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local options = { buffer = event.buf }
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', options)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', options)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', options)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', options)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', options)
        -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', options)
        vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', options)
    end,
})

-- Server configurations table
local server_configs = {
    matlab_ls = {
        settings = {
            matlab = {
                installPath = "/home/sorokinoleg/MATLAB", -- This path might need to be user-configurable in the future
                indexWorkspace = true,
            },
        },
    },
    glslls = {
        cmd = { "glslls", "--stdin", "--target-env", "opengl" },
    },
    pyright = {
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = "off",
                },
            },
        },
    },
    clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--header-insertion=never",
            "--query-driver=**",
        },
    },
    ocamllsp = {
        cmd = { "ocamllsp" },
    }
    -- Note: arduino_language_server is handled specially in the loop
    -- lua_ls, bashls, rust_analyzer, neocmake, tsserver, julials will use default {}
}

-- Setup LSPs based on user_lsp_servers
for _, server_name in ipairs(user_lsp_servers) do
    local setup_opts = server_configs[server_name] or {}
    if server_name == "arduino_language_server" then
        LSP_config.arduino_language_server.setup({
            on_new_config = function(config, _)
                local lines = read_lines(vim.fn.getcwd() .. "/.fqbn")
                local fqbn = "arduino:avr:uno" -- Default FQBN
                if #lines >= 1 then
                    local trimmed_line = trim_string(lines[1])
                    if trimmed_line ~= "" then
                        fqbn = trimmed_line
                    end
                end
                vim.notify(string.format("Arduino LSP: Using FQBN = %s", fqbn), vim.log.levels.INFO, {
                    title = "Arduino Language Server",
                    timeout = 5000,
                })
                config.cmd = {
                    "arduino-language-server",
                    "-fqbn",
                    fqbn,
                }
            end,
        })
    elseif LSP_config[server_name] then
        LSP_config[server_name].setup(setup_opts)
    else
        vim.notify("LSP: Configuration not found for " .. server_name .. ", skipping.", vim.log.levels.WARN, { title = "LSP Configuration" })
    end
end

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

-- Individual LSP_config.<server_name>.setup calls are now handled by the loop above.
-- Commenting out the old individual setup calls:
--
-- LSP_config.lua_ls.setup({})
-- LSP_config.bashls.setup({})
-- LSP_config.rust_analyzer.setup({})
-- LSP_config.neocmake.setup({})
--
-- LSP_config.matlab_ls.setup({ ... }) -- Handled by server_configs
-- LSP_config.glslls.setup({ ... }) -- Handled by server_configs
-- LSP_config.pyright.setup({ ... }) -- Handled by server_configs
-- LSP_config.arduino_language_server.setup({ ... }) -- Handled by special case in loop
-- LSP_config.tsserver.setup({})
-- LSP_config.julials.setup({})
-- LSP_config.clangd.setup({ ... }) -- Handled by server_configs
-- LSP_config.ocamllsp.setup({ ... }) -- Handled by server_configs

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
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
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
        ['<C-j>'] = CMP.mapping(function(fallback)
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
        ['<C-k>'] = CMP.mapping.abort(),
        ['<C-p>'] = CMP.mapping.select_prev_item({ behavior = 'select' }),
        ['<C-n>'] = CMP.mapping.select_next_item({ behavior = 'select' }),
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
