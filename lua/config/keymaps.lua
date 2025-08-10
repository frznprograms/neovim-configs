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
vim.keymap.set({ "n", "v" }, "<leader>y", "+y", { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", "+Y", { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", "+p", { desc = "Paste from clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", "+P", { desc = "Paste before from clipboard" })

-- Resize splits
vim.keymap.set("n", "<M-l>", ":vertical resize +2<CR>", { desc = "Wider", silent = true })
vim.keymap.set("n", "<M-h>", ":vertical resize -2<CR>", { desc = "Narrower", silent = true })
vim.keymap.set("n", "<M-k>", ":resize +2<CR>", { desc = "Taller", silent = true })
vim.keymap.set("n", "<M-j>", ":resize -2<CR>", { desc = "Shorter", silent = true })

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
    "<cmd>MoltenEvaluateOperator<CR>",
    { desc = "Molten: eval operator", silent = true }
  )
  vim.keymap.set(
    "n",
    "<localleader>os",
    "<cmd>noautocmd MoltenEnterOutput<CR>",
    { desc = "Molten: open output", silent = true }
  )
  vim.keymap.set(
    "n",
    "<localleader>rr",
    "<cmd>MoltenReevaluateCell<CR>",
    { desc = "Molten: re-eval cell", silent = true }
  )
  vim.keymap.set(
    "v",
    "<localleader>r",
    "<cmd>MoltenEvaluateVisual<CR>gv",
    { desc = "Molten: eval visual", silent = true }
  )
  vim.keymap.set("n", "<localleader>oh", "<cmd>MoltenHideOutput<CR>", { desc = "Molten: hide output", silent = true })
  vim.keymap.set("n", "<localleader>md", "<cmd>MoltenDelete<CR>", { desc = "Molten: delete cell", silent = true })
end

-- Quarto (localleader)
local ok_quarto, quarto = pcall(require, "quarto")
if ok_quarto then
  vim.keymap.set("n", "<localleader>qp", quarto.quartoPreview, { desc = "Quarto preview", silent = true })
  local ok_runner, runner = pcall(require, "quarto.runner")
  if ok_runner then
    vim.keymap.set("n", "<localleader>rc", function()
      runner.run_cell()
    end, { desc = "Quarto: run cell", silent = true })
    vim.keymap.set("n", "<localleader>ra", function()
      runner.run_above()
    end, { desc = "Quarto: run above", silent = true })
    vim.keymap.set("n", "<localleader>rA", function()
      runner.run_all()
    end, { desc = "Quarto: run all (file)", silent = true })
    vim.keymap.set("n", "<localleader>rl", function()
      runner.run_line()
    end, { desc = "Quarto: run line", silent = true })
    vim.keymap.set("v", "<localleader>r", function()
      runner.run_range()
    end, { desc = "Quarto: run visual range", silent = true })
    vim.keymap.set("n", "<localleader>RA", function()
      runner.run_all(true)
    end, { desc = "Quarto: run all languages", silent = true })
  end
end
