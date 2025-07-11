vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function() vim.o.clipboard = "unnamedplus" end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- vim.o.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- ADDITIONAL OPTIONS
vim.o.wrap = true
vim.o.shellquote = ""
vim.o.shellxquote = ""
vim.o.shell = vim.fn.has "win32" == 1 and "pwsh" or "sh"
vim.o.shellcmdflag = vim.fn.has "win32" == 1 and "-NoLogo -NoProfile -Command" or "-c"

-- Set the number of spaces a tab "counts" for.
vim.opt.tabstop = 2

-- Set the number of spaces to use for indentation.
vim.opt.shiftwidth = 2

-- When inserting a tab, insert spaces instead.
vim.opt.expandtab = true

-- Copy indent from the previous line.
vim.opt.autoindent = true

-- Smart indentation for C-like languages (and many others).
vim.opt.smartindent = true

-- vim: ts=2 sts=2 sw=2 et
