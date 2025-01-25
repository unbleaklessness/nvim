-- local LSP = require("lsp-zero")

-- LSP.on_attach(function(_ --[[ Client. ]], buffer_number)
--     LSP.default_keymaps({ buffer = buffer_number })
-- end)

require("mason").setup()

local ensure_installed = {
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
    "bashls",
}

require("mason-lspconfig").setup({ ensure_installed = ensure_installed })

-- vim.api.nvim_create_user_command("MasonInstallAll", function()
--     local registry = require("mason-registry")
--     local Package = require("mason-core.package")
--     local async = require("mason-core.async")
--
--     async.run_blocking(function()
--         for _, package in ipairs(ensure_installed) do
--             local pkg = registry.get_package(Package.Parse(package))
--             if not pkg:is_installed() then
--                 local handle = pkg:install()
--                 handle:wait()
--             end
--         end
--     end)
-- end, { desc = "Install all packages specified in the config." })

vim.api.nvim_create_user_command("MasonInstallAll", function()
        local lspconfig_to_package = require("mason-lspconfig.mappings.server").lspconfig_to_package
        for _, package in ipairs(ensure_installed) do
            local server_name = lspconfig_to_package[package]
            if server_name then
                vim.cmd("MasonInstall " .. server_name)
                vim.notify("Installed LSP package: " .. server_name, vim.log.levels.INFO)
            else
                vim.cmd("MasonInstall " .. package)
                vim.notify("Installed regular package: " .. package, vim.log.levels.INFO)
            end
        end
    end,
    {
        desc = "Install all packages specified in the config.",
        nargs = 0,
    })

-- vim.api.nvim_create_user_command("MasonInstallAll", function()
--     for v in ensure_installed do
--         vim.cmd("MasonInstall " .. v)
--     end
--
--     -- -- vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
--     -- -- error("Error")
--     -- -- print('lalal')
--     -- -- os.exit(-1)
--     --
--     -- -- vim.cmd("Lazy! install all")
--     -- -- vim.cmd("Lazy load all")
--     -- -- vim.cmd("Mason")
--     -- -- vim.cmd("MasonUpdate")
--     --
--     -- local lazy = require("lazy.core.config")
--     --
--     -- local nvim_lsp = lazy.plugins["nvim-lspconfig"]
--     -- local mason = lazy.plugins["mason.nvim"]
--     --
--     -- local registry = require("mason-registry")
--     --
--     -- local function contains(array, element)
--     --     for _, value in ipairs(array) do
--     --         if value == element then
--     --             return true
--     --         end
--     --     end
--     --     return false
--     -- end
--     --
--     -- -- Stuff below is for converting package aliases to names
--     -- local all_package_names = registry.get_all_package_names()
--     -- local alias_to_name = {}
--     --
--     -- for _, package_name in pairs(all_package_names) do
--     --     local aliases = registry.get_package_aliases(package_name)
--     --     if aliases then
--     --         for _, alias in pairs(aliases) do
--     --             alias_to_name[alias] = package_name
--     --         end
--     --         alias_to_name[package_name] = package_name
--     --     end
--     -- end
--     --
--     -- -- local already_installed = registry.get_installed_package_names()
--     -- local already_installed = ensure_installed
--     -- local new_already_installed = {}
--     -- for idx, v in ipairs(already_installed) do
--     --     -- already_installed[idx] = alias_to_name[v]
--     --     new_already_installed[idx] = alias_to_name[v]
--     -- end
--     --
--     -- -- Load all packages into a list
--     -- local mason_stuff = {}
--     --
--     -- -- -- LSP packages installed via `nvim-lspconfig`
--     -- -- local servers = nvim_lsp._.cache.opts.servers
--     -- -- for server_name, _ in pairs(servers) do
--     -- --     server_name = alias_to_name[server_name]
--     -- --     if not contains(already_installed, server_name) then
--     -- --         table.insert(mason_stuff, server_name)
--     -- --     end
--     -- -- end
--     --
--     -- -- -- Mason apps installed
--     -- -- local mason_apps = ensure_installed
--     -- -- for _, mason_app in pairs(mason_apps) do
--     -- --     mason_app = alias_to_name[mason_app]
--     -- --     if not contains(already_installed, mason_app) then
--     -- --         table.insert(mason_stuff, mason_app)
--     -- --     end
--     -- -- end
--     --
--     -- local function install_mason_package(package_name)
--     --     local job_id = vim.fn.jobstart(vim.cmd("MasonInstall " .. package_name), {
--     --         on_exit = function(_, code)
--     --             if code == 0 then
--     --                 print("Installed " .. package_name)
--     --             else
--     --                 print("Failed to install " .. package_name)
--     --             end
--     --         end,
--     --     })
--     --
--     --     vim.fn.jobwait({ job_id }, -1)
--     --     -- if job_id > 0 then
--     --     --     vim.fn.jobwait({ job_id }, -1)
--     --     -- else
--     --     --     print("Failed to start job for " .. package_name)
--     --     -- end
--     -- end
--     --
--     -- -- Install them one by one
--     -- -- for _, v in ipairs(mason_stuff) do
--     -- for _, v in ipairs(new_already_installed) do
--     --     install_mason_package(v)
--     --     -- vim.cmd("MasonInstall " .. v)
--     --     -- os.exit(1)
--     -- end
-- end, {})

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
