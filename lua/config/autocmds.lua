vim.diagnostic.config({ float = { border = "rounded" } })

-- Highlight the window separators
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#61AFEF" })

-- for markdown and txt, set textwidth to 80
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = "80"
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})
