vim.diagnostic.config({ float = { border = "rounded" } })

-- Highlight the window separators
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#61AFEF" })

-- link Blink-cmp colourscheme to nvim colourscheme
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     local function link(from, to)
--       vim.api.nvim_set_hl(0, from, { link = to })
--     end
--
--     -- Completion menu
--     link("BlinkCmpMenu", "Pmenu")
--     link("BlinkCmpMenuSelection", "PmenuSel")
--     link("BlinkCmpMenuBorder", "FloatBorder")
--
--     -- Documentation window
--     link("BlinkCmpDoc", "NormalFloat")
--     link("BlinkCmpDocBorder", "FloatBorder")
--
--     -- Signature help (if you use it)
--     link("BlinkCmpSignatureHelp", "NormalFloat")
--     link("BlinkCmpSignatureHelpBorder", "FloatBorder")
--   end,
-- })
