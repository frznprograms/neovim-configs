-- 4-space indentation globally
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

-- Override for Lua: 2-space (stylua standard)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- only for rose pine theme
vim.opt.pumblend = 10

-- set custom cursor
vim.opt.guicursor = table.concat({
  "n-v-c:block",                                -- normal, visual, command → block
  "i:blinkwait20-blinkoff250-blinkon250-block", -- insert → blinking block
  "r-cr:hor20",                                 -- replace modes → horizontal bar
  "o:hor50",                                    -- operator-pending → thicker bar
}, ",")

-- enable text wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
