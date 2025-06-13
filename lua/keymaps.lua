-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode easily
-- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Helper for cleaner mappings
local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc }) end

map("n", "<leader>tc", "<Cmd>Telescope colorscheme<CR>", "Toggle colorscheme")

map("i", "<C-p>", "<Esc>pi", "Paste in insert mode")

-- Line movement
map("n", "<leader>9", "$", "Go to end of line")
-- map("i", "99", "<Esc>$a", "Go to end of line")
-- map("i", "00", "<Esc>0i", "Go to start of line")

-- Save
map("i", "<C-s>", "<Esc>:write!<CR>i", "Save file")
map("n", "<Leader>w", ":write!<CR>", "Save file")

-- Exit insert mode
map("i", "jk", "<Esc>", "Exit insert mode")

-- Move lines
map("n", "<A-j>", ":move .+1<CR>==", "Move line down")
map("n", "<A-k>", ":move .-2<CR>==", "Move line up")

-- Move visual selection
map("v", "<A-j>", ":move '>+1<CR>gv=gv", "Move selection down")
map("v", "<A-k>", ":move '<-2<CR>gv=gv", "Move selection up")

-- Close terminal
map("t", "<C-q>", "<C-\\><C-n>:q<CR>", "Close terminal")

-- Resize buffer
map("n", "<C-Up>", ":resize +2<CR>", "Increase buffer height")
map("n", "<C-Down>", ":resize -2<CR>", "Decrease buffer height")
map("n", "<C-Left>", ":vertical resize -2<CR>", "Decrease buffer width")
map("n", "<C-Right>", ":vertical resize +2<CR>", "Increase buffer width")

-- ToggleTerm mappings
map("n", "<Leader>t", "", "Toggle terminal")
map("n", "<Leader>th", ":ToggleTerm direction=horizontal<CR>", "Toggle horizontal terminal")
map("n", "<Leader>tv", ":ToggleTerm direction=vertical<CR>", "Toggle vertical terminal")
map("n", "<Leader>tf", ":ToggleTerm direction=float<CR>", "Toggle floating terminal")

-- Barbar buffer navigation
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", "Previous buffer")
map("n", "<A-.>", "<Cmd>BufferNext<CR>", "Next buffer")
map("n", "<S-l>", ":bnext<CR>", "Next buffer")
map("n", "<S-h>", ":bprevious<CR>", "Previous buffer")

-- Buffer reordering
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", "Move buffer previous")
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", "Move buffer next")

-- Go to buffer by number
for i = 1, 9 do
  map("n", "<A-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", "Go to buffer " .. i)
end
map("n", "<A-0>", "<Cmd>BufferLast<CR>", "Go to last buffer")

-- Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>", "Pin/Unpin buffer")

-- Buffer commands
map("n", "<Leader>b", "", "Buffer")
map("n", "<Leader>cc", "<Cmd>BufferClose<CR>", "Close buffer")
map("n", "<Leader>bc", "<Cmd>BufferClose<CR>", "Close buffer")
map("n", "<Leader>bq", "<Cmd>BufferWipeout<CR>", "Wipeout buffer")
map("n", "<Leader>bx", "<Cmd>BufferCloseAllButCurrent<CR>", "Close all but current")
map("n", "<Leader>bP", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", "Close all but current/pinned")
map("n", "<Leader>b,", "<Cmd>BufferCloseBuffersLeft<CR>", "Close buffers left")
map("n", "<Leader>b.", "<Cmd>BufferCloseBuffersRight<CR>", "Close buffers right")

-- Buffer picking
map("n", "<C-p>", "<Cmd>BufferPick<CR>", "Buffer pick mode")
map("n", "<C-s-p>", "<Cmd>BufferPickDelete<CR>", "Buffer pick and delete")

-- Buffer sorting
map("n", "<Leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", "Sort buffers by number")
map("n", "<Leader>bn", "<Cmd>BufferOrderByName<CR>", "Sort buffers by name")
map("n", "<Leader>bd", "<Cmd>BufferOrderByDirectory<CR>", "Sort buffers by directory")
map("n", "<Leader>bl", "<Cmd>BufferOrderByLanguage<CR>", "Sort buffers by language")
map("n", "<Leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", "Sort buffers by window number")

-- LSP
map("n", "<Leader>l", "", "LSP")
map("n", "<Leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition")
map("n", "<Leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation")
map("n", "<Leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to type definition")
map("n", "<Leader>lR", "<cmd>lua vim.lsp.buf.references()<CR>", "Show references")
map("n", "<Leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover documentation")
map("n", "<Leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help")
map("n", "<Leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action")
map("n", "<Leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol")
map("n", "<Leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format file")
map("n", "<Leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>", "Open float with diagnostic details")

-- Git prefix placeholder
map("n", "<Leader>g", "", "Git")

-- CodeCompanion
map("n", "<leader>i", "", "AI")
map("n", "<leader>ic", "<cmd>CodeCompanion<CR>", "CodeCompanion")
map("n", "<leader>iC", "<cmd>CodeCompanionChat<CR>", "CodeCompanion Chat")
map("n", "<leader>ia", "<cmd>CodeCompanionActions<CR>", "CodeCompanion Actions")
map("n", "<leader>id", "<cmd>CodeCompanionCmd<CR>", "CodeCompanion CMD")

vim.keymap.set("i", "<C-n>", function()
  local cmp = require "cmp"
  if cmp and cmp.visible() then
    cmp.abort()
  else
    cmp.complete()
  end
end, { desc = "Trigger completion suggestions" })
