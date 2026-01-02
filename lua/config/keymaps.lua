-- copy and paste
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank something to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste something from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste line from system clipboard" })

-- Resize splits dynamically
vim.keymap.set("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Resize window 2 clicks up" })
vim.keymap.set("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Resize window 2 clicks down" })
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Resize window 2 clicks left" })
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Resize window 2 clicks right" })
