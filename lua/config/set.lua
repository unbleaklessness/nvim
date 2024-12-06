vim.g.mapleader = " "

vim.opt.nu = true -- Enable line numbers.
vim.opt.relativenumber = true -- Enable negative line numbers.

vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for.
vim.opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent.
vim.opt.expandtab = true -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.

-- vim.opt.smartindent = true -- Do smart autoindenting when starting a new line.
vim.opt.smartindent = false -- Do smart autoindenting when starting a new line.

-- Case-insensitive search, unless '\C' or a capital letter is present in the search.
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 250 -- If this many milliseconds nothing is typed the swap file will be written to disk. Also used for the 'CursorHold' event.
vim.o.timeoutlen = 1000 -- Time in milliseconds to wait for a mapped sequence to complete.

vim.opt.wrap = false -- When on, lines longer than the width of the window will wrap and displaying continues on the next line.

vim.opt.backup = false -- Make a backup before overwriting a file. Leave it around after the file has been successfully written.
vim.opt.swapfile = false -- Use a swap file for the buffer.  This option can be reset when a swap file is not wanted for a specific buffer.

vim.opt.hlsearch = true -- When there is a previous search pattern, highlight all its matches.
vim.opt.incsearch = true -- While typing a search command, show where the pattern, as it was typed so far, matches.

vim.opt.termguicolors = true -- Enables 24-bit RGB color in the TUI.

vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 20 -- The minimal number of screen columns to keep to the left and to the right of the cursor.
vim.opt.signcolumn = "yes:1" -- When and how to draw the sign column.

vim.opt.colorcolumn = "" -- Is a comma-separated list of screen columns that are highlighted.

vim.opt.keymap = "russian-jcukenwin" -- Built-in Russian keyboard layout.
vim.opt.iminsert = 0 -- Do not use the Russian keyboard layout when NeoVim initially starts.

vim.opt.guifont = "JetBrainsMono Nerd Font:h15" -- Set font and font size for GUI NeoVim.

-- vim.api.nvim_exec('language en_US', true) -- Set NeoVim language to English.
vim.api.nvim_exec("language en_US.UTF-8", true) -- Set NeoVim language to English.

-- Display whitespace characters.
-- vim.opt.list = true
-- vim.opt.listchars:append "space:·"
-- vim.opt.listchars:append "eol:↴"
-- vim.opt.listchars:append "tab:▸·"

-- vim.opt.conceallevel = 2

vim.opt.cursorline = true -- Highlight the text line of the cursor.

vim.opt.undofile = true -- When on, Vim automatically saves undo history to an undo file when writing a buffer to a file, and restores undo history from the same file on buffer read.
vim.opt.undolevels = 3000 -- Maximum number of changes that can be undone.

vim.opt.autoread = true -- When a file has been detected to have been changed outside of Vim and it has not been changed inside of Vim, automatically read it again.

-- Reload the current file if it has been changed externally.
vim.cmd([[
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
]])

vim.cmd([[
    augroup keyboard_layout_switch
        autocmd!

        let g:english_layout = "us"
        let g:insert_mode_layout = g:english_layout

        function s:leave_insert_mode()
            let g:insert_mode_layout = trim(system('xkb-switch'))
            call system('xkb-switch -s "' . g:english_layout . '"')
        endfunction

        function s:enter_insert_mode()
            call system('xkb-switch -s "' . g:insert_mode_layout . '"')
        endfunction

        autocmd InsertLeave * call s:leave_insert_mode()
        autocmd InsertEnter * call s:enter_insert_mode()
    augroup END
]])
