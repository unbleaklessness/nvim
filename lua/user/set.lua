vim.g.mapleader = " "

vim.opt.nu = true -- Enable line numbers.
vim.opt.relativenumber = true -- Enable negative line numbers.

vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for.
vim.opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent.
vim.opt.expandtab = true -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.

vim.opt.smartindent = true -- Do smart autoindenting when starting a new line.

vim.opt.wrap = false -- When on, lines longer than the width of the window will wrap and displaying continues on the next line.

vim.opt.backup = false -- Make a backup before overwriting a file. Leave it around after the file has been successfully written.
vim.opt.swapfile = false -- Use a swap file for the buffer.  This option can be reset when a swap file is not wanted for a specific buffer.

vim.opt.hlsearch = true -- When there is a previous search pattern, highlight all its matches.
vim.opt.incsearch = true -- While typing a search command, show where the pattern, as it was typed so far, matches.

vim.opt.termguicolors = true -- Enables 24-bit RGB color in the TUI.

vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 20 -- The minimal number of screen columns to keep to the left and to the right of the cursor.
vim.opt.signcolumn = "auto:3" -- When and how to draw the sign column.

vim.opt.updatetime = 50 -- If this many milliseconds nothing is typed the swap file will be written to disk.

vim.opt.colorcolumn = "80" -- Is a comma-separated list of screen columns that are highlighted.

vim.opt.keymap = "russian-jcukenwin" -- Built-in Russian keyboard layout.
vim.opt.iminsert = 0 -- Do not use the Russian keyboard layout when NeoVim initially starts.

vim.opt.guifont = "Ubuntu Nerd Font:h20" -- Set font and font size for GUI NeoVim.

-- vim.api.nvim_exec('language en_US', true)
vim.api.nvim_exec('language en_US.UTF-8', true) -- Set NeoVim language to English.

-- Display whitespace characters.
-- vim.opt.list = true
-- vim.opt.listchars:append "space:·"
-- vim.opt.listchars:append "eol:↴"
-- vim.opt.listchars:append "tab:▸·"

vim.opt.autowriteall = true -- Write the contents of the file, if it has been modified.

vim.opt.cursorline = true -- Highlight the text line of the cursor.

