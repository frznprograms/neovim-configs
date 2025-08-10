-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(buffnr)
  local keymap = vim.keymap
  local opts = { noremap = true, silent = true, buffer = buffnr }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

  -- delete a word backwards
  vim.keymap.set("n", "dw", "vb_d")

  -- select all
  vim.keymap.set("n", "<C-a>", "gg<S-v>G")

  -- jumplist
  vim.keymap.set("n", "<C-m>", "<C-i>", opts)

  -- new tab
  vim.keymap.set("n", "te", ":tabedit", opts)
  -- tab navigation
  vim.keymap.set("n", "<tab>", ":tabnext<CR>", opts)
  vim.keymap.set("n", "<s-tab>", ":tabprev<CR>", opts)

  -- Yank to system clipboard
  vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
  vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

  -- Paste from system clipboard
  vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
  vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard" })

  -- resize windows
  vim.keymap.set("n", "<A-left>", "<C-w>>")
  vim.keymap.set("n", "<A-right>", "<C-w><")
  vim.keymap.set("n", "<A-up>", "<C-w>+")
  vim.keymap.set("n", "<A-down>", "<C-w>-")

  -- diagnostic
  vim.keymap.set("n", "<C-j>", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, opts)

  -- molten basic keymaps
  vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
  vim.keymap.set(
    "n",
    "<localleader>os",
    ":noautocmd MoltenEnterOutput<CR>",
    { desc = "open output window", silent = true }
  )

  -- additional molten keymaps
  vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
  vim.keymap.set(
    "v",
    "<localleader>r",
    ":<C-u>MoltenEvaluateVisual<CR>gv",
    { desc = "execute visual selection", silent = true }
  )
  vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
  vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

  -- quarto preview keymap
  local quarto = require("quarto")
  vim.keymap.set("n", "<leader>qp", quarto.quartoPreview, { silent = true, noremap = true })

  local runner = require("quarto.runner")
  vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
  vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
  vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
  vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
  vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
  vim.keymap.set("n", "<localleader>RA", function()
    runner.run_all(true)
  end, { desc = "run all cells of all languages", silent = true })
end

-- remove annoying warning at the end of jupyter notebooks
require("lspconfig")["pyright"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        diagnosticSeverityOverrides = {
          reportUnusedExpression = "none",
        },
      },
    },
  },
})
