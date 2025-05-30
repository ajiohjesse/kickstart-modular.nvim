-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>d', "", { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- ADDITIONAL KEYMAPS

local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc }) end

-- save
map("i", "<C-s>", ":write!<CR>", "Save file")
map("n", "<Leader>w", ":write!<CR>", "Save file")

-- exit insert mode
map("i", "jk", "<Esc>", "Exit insert mode")
map("i", "jj", "<Esc>", "Exit insert mode")

-- move lines
map("n", "<A-j>", ":move .+1<CR>==", "Move line down")
map("n", "<A-k>", ":move .-2<CR>==", "Move line up")

--move selection
map("v", "<A-j>", ":move '>+1<CR>gv=gv", "Move selection down")
map("v", "<A-k>", ":move '<-2<CR>gv=gv", "Move selection up")

--close terminal
map("t", "<C-q>", "C-\\><C-n>:q<CR>", "Close terminal")

-- close buffer
map("n", "<Leader>q", ":q<CR>", "Close buffer" )

-- resize buffer
map("n", "<C-Up>", ":resize +2<CR>", "Increase buffer height")
map("n", "<C-Down>", ":resize -2<CR>", "Decrease buffer height")
map("n", "<C-Left>", ":vertical resize -2<CR>", "Decrease buffer width")
map("n", "<C-Right>", ":vertical resize +2<CR>", "Increase buffer width")

-- toggle terminal
map("n", "<Leader>t", "", "Toggle terminal")
map("n", "<Leader>th", ":ToggleTerm direction=horizontal<CR>", "Toggle horizontal terminal")
map("n", "<Leader>tv", ":ToggleTerm direction=vertical<CR>", "Toggle vertical terminal")
map("n", "<Leader>tf", ":ToggleTerm direction=float<CR>", "Toggle floating terminal")

-- barbar.nvim buffer navigation and management mappings
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', "Previous buffer")
map('n', '<A-.>', '<Cmd>BufferNext<CR>', "Next buffer")

-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', "Move buffer previous")
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', "Move buffer next")

-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', "Go to buffer 1")
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', "Go to buffer 2")
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', "Go to buffer 3")
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', "Go to buffer 4")
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', "Go to buffer 5")
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', "Go to buffer 6")
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', "Go to buffer 7")
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', "Go to buffer 8")
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', "Go to buffer 9")
map('n', '<A-0>', '<Cmd>BufferLast<CR>', "Go to last buffer")

-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', "Pin/Unpin buffer")


map('n', '<Leader>b', '', "Buffer")

-- Goto pinned/unpinned buffer (These don't have simple command forms for mapping with a single key, you'd typically type these)
--                 :BufferGotoPinned
--                 :BufferGotoUnpinned

-- Close buffer
map('n', '<Leader>bc', '<Cmd>BufferClose<CR>', "Close buffer")

-- Wipeout buffer (Typically typed command)
--                 :BufferWipeout
map('n', '<Leader>bq', '<Cmd>BufferWipeout<CR>', "Wipeout buffer")

-- Close commands (Typically typed commands)
--                 :BufferCloseAllButCurrent
map('n', '<Leader>bC', '<Cmd>BufferCloseAllButCurrent<CR>', "Close all but current")
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
map('n', '<Leader>bP', '<Cmd>BufferCloseAllButCurrentOrPinned<CR>', "Close all but current/pinned")
--                 :BufferCloseBuffersLeft
map('n', '<Leader>b,', '<Cmd>BufferCloseBuffersLeft<CR>', "Close buffers left")
--                 :BufferCloseBuffersRight
map('n', '<Leader>b.', '<Cmd>BufferCloseBuffersRight<CR>', "Close buffers right")

-- Magic buffer-picking mode
map('n', '<C-p>',   '<Cmd>BufferPick<CR>', "Buffer pick mode")
map('n', '<C-s-p>', '<Cmd>BufferPickDelete<CR>', "Buffer pick and delete")

-- Sort automatically by...
map('n', '<Leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', "Sort buffers by number")
map('n', '<Leader>bn', '<Cmd>BufferOrderByName<CR>', "Sort buffers by name")
map('n', '<Leader>bd', '<Cmd>BufferOrderByDirectory<CR>', "Sort buffers by directory")
map('n', '<Leader>bl', '<Cmd>BufferOrderByLanguage<CR>', "Sort buffers by language")
map('n', '<Leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', "Sort buffers by window number")

-- vim: ts=2 sts=2 sw=2 et
