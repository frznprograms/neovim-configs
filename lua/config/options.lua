-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.g.maplocalleader = "\\"

-- only for the rose pine theme
vim.opt.pumblend = 10

-- for indent guides
vim.g.lazyvim_indent_scope_enabled = true

-- set custom cursor
vim.opt.guicursor = table.concat({
  "n-v-c:block", -- normal, visual, command → block
  "i:blinkwait20-blinkoff250-blinkon250-block", -- insert → blinking block
  "r-cr:hor20", -- replace modes → horizontal bar (optional)
  "o:hor50", -- operator-pending → thicker bar (optional)
}, ",")
