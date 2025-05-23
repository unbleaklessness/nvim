-- This file determines which LSP servers are activated and installed.
-- Add the names of the LSP servers you want to use to the 'active_servers' table.
--
-- Example:
-- local active_servers = {
--   "lua_ls",
--   "pyright",
-- }
--
-- Available servers (comment out or remove to disable):
-- local all_servers = {
--   "lua_ls",
--   "clangd",
--   -- "gopls",
--   "neocmake",
--   "pyright",
--   "arduino_language_server",
--   "emmet_ls",
--   "clojure_lsp",
--   -- "glslls",
--   "julials",
--   "rust_analyzer",
--   "matlab_ls",
--   "bashls",
--   "tsserver",
--   "ocamllsp",
-- }
--
-- return active_servers -- Or some logic to select from all_servers

local active_servers = {
  "lua_ls",
  "pyright",
  -- Add more servers here as needed, for example:
  -- "rust_analyzer",
  -- "clangd",
}

-- To help you choose, here's a list of servers that were previously configured in lua/config/plugin_configs/LSP.lua:
-- "lua_ls",
-- "clangd",
-- -- "gopls", -- This was commented out in the original configuration
-- "neocmake",
-- "pyright",
-- "arduino_language_server",
-- "emmet_ls",
-- "clojure_lsp",
-- -- "glslls", -- This was commented out in the original configuration
-- "julials",
-- "rust_analyzer",
-- "matlab_ls",
-- "bashls",
-- "tsserver", -- This was missing from ensure_installed but configured later
-- "ocamllsp", -- This was missing from ensure_installed but configured later

return active_servers
