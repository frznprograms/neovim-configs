-- ~/.config/nvim/lua/config/keymaps.lua (LazyVim)
-- Loaded on VeryLazy. Adds/overrides custom keymaps safely.

-- LSP on_attach: (client, bufnr) order matters!
local opts = { noremap = true, silent = true }

-- LSP basics
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

-- Delete a word backwards (keep cursor at start of deleted word)
-- "vb\"_d": visual select back to word start, delete into black‑hole register
vim.keymap.set("n", "dw", 'vb"_d', opts)

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select entire buffer", silent = true })

-- Jumplist helpers (optional: mirror <C-o>/<C-i>)
vim.keymap.set("n", "[j", "<C-o>", { desc = "Jump back", silent = true })
vim.keymap.set("n", "]j", "<C-i>", { desc = "Jump forward", silent = true })

-- Tabs
vim.keymap.set("n", "te", ":tabedit<CR>", { desc = "New tab", silent = true })
vim.keymap.set("n", "]t", ":tabnext<CR>", { desc = "Next tab", silent = true })
vim.keymap.set("n", "[t", ":tabprev<CR>", { desc = "Prev tab", silent = true })

-- System clipboard (overrides).
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from clipboard" })

-- Resize splits
-- vim.keymap.set("n", "<A-w>l", ":vertical resize +2<CR>", { desc = "Wider", silent = true })
-- vim.keymap.set("n", "<A-w>h", ":vertical resize -2<CR>", { desc = "Narrower", silent = true })
-- vim.keymap.set("n", "<A-w>k", ":resize +2<CR>", { desc = "Taller", silent = true })
-- vim.keymap.set("n", "<A-w>j", ":resize -2<CR>", { desc = "Shorter", silent = true })

-- Telescope live_multigrep
vim.keymap.set("n", "<leader>mg", function()
  require("plugins.telescope_multigrep").live_multigrep()
end, { desc = "Telescope: Multi grep" })

-- Diagnostics
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ float = true })
end, { desc = "next diagnostic", silent = true })

-- Molten (guard if not installed)
-- Molten (localleader)
local has_molten = pcall(require, "molten")
if has_molten then
  vim.keymap.set(
    "n",
    "<localleader>e",
    ":MoltenEvaluateOperator<CR>",
    { desc = "Molten: eval operator", silent = true }
  )
  vim.keymap.set(
    "n",
    "<localleader>os",
    ":noautocmd MoltenEnterOutput<CR>",
    { desc = "Molten: open output", silent = true }
  )
  vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "Molten: re-eval cell", silent = true })
  vim.keymap.set("v", "<localleader>r", ":MoltenEvaluateVisual<CR>gv", { desc = "Molten: eval visual", silent = true })
  vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "Molten: hide output", silent = true })
  vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "Molten: delete cell", silent = true })
end

-- Quarto (localleader)
local has_quarto, quarto = pcall(require, "quarto")
if has_quarto then
  vim.keymap.set("n", "<localleader>qp", quarto.quartoPreview, { desc = "Quarto preview", silent = true })
  local ok_runner, runner = pcall(require, "quarto.runner")
  if ok_runner then
    vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "Quarto: run cell", silent = true })
    vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "Quarto: run above", silent = true })
    vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "Quarto: run all", silent = true })
    vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "Quarto: run line", silent = true })
    vim.keymap.set("n", "<localleader>RA", function()
      runner.run_all(true)
    end, { desc = "Quarto: run all languages", silent = true })
  end
end

vim.keymap.set("v", "<localleader>r", function()
  local ok, runner = pcall(require, "quarto.runner")
  if ok then
    local ran = pcall(runner.run_range)
    if ran then
      return
    end
  end
  -- fallback: run exactly what you selected via Molten
  vim.cmd(":<C-u>MoltenEvaluateVisual")
end, { silent = true, desc = "Run visual range (Quarto cell or raw via Molten)" })
