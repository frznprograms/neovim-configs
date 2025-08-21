-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`

vim.opt.smartindent = false
vim.opt.autoindent = true
vim.opt.cindent = false
vim.opt_local.indentexpr = "" -- let lsp handle it

-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.diagnostic.config({ float = { border = "rounded" } })
-- Set window separator characters and highlight
vim.opt.fillchars:append({
  horiz = "─",
  horizup = "┴",
  horizdown = "┬",
  vert = "│",
  vertleft = "┤",
  vertright = "├",
  verthoriz = "┼",
})

-- Highlight the window separators
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#61AFEF" })

-- Molten autocmds
-- I find auto open annoying, keep in mind setting this option will require setting
-- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
vim.g.molten_auto_open_output = true

-- this guide will be using image.nvim
-- Don't forget to setup and install the plugin if you want to view image outputs
vim.g.molten_wrap_output = true
-- Output as virtual text. Allows outputs to always be shown, works with images, but can
-- be buggy with longer images
vim.g.molten_virt_text_output = true
-- this will make it so the output shows up below the \``\` cell delimiter
vim.g.molten_virt_lines_off_by_1 = true

-- converts markdown to quarto format so we can always run code easily
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = "*.md",
  callback = function(args)
    -- Only switch to Quarto if we see a curly-fenced chunk like ```{python}
    local n = math.min(200, vim.api.nvim_buf_line_count(args.buf))
    for i = 1, n do
      local line = vim.api.nvim_buf_get_lines(args.buf, i - 1, i, false)[1]
      if line and line:match("^%s*```%s*{[%w_%-]+") then
        vim.bo[args.buf].filetype = "quarto"
        break
      end
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h", "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
-- pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
-- callback = function()
-- vim.opt_local.shiftwidth = 2
-- vim.opt_local.tabstop = 2
-- end,
-- })
