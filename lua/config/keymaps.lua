-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- delete a word backwards
keymap.set("n", "dw", "vb_d")

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- new tab
keymap.set("n", "te", ":tabedit", opts)
-- tab navigation
keymap.set("n", "<tab>", ":tabnext<CR>", opts)
keymap.set("n", "<s-tab>", ":tabprev<CR>", opts)

-- Yank to system clipboard
keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Paste from system clipboard
keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard" })

-- resize windows
keymap.set("n", "<A-left>", "<C-w>>")
keymap.set("n", "<A-right>", "<C-w><")
keymap.set("n", "<A-up>", "<C-w>+")
keymap.set("n", "<A-down>", "<C-w>-")

-- diagnostic
keymap.set("n", "<C-j>", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, opts)
