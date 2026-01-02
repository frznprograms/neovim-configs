-- only for rose pine theme
vim.opt.pumblend = 10

-- set custom cursor
vim.opt.guicursor = table.concat({
  "n-v-c:block",                                -- normal, visual, command → block
  "i:blinkwait20-blinkoff250-blinkon250-block", -- insert → blinking block
  "r-cr:hor20",                                 -- replace modes → horizontal bar
  "o:hor50",                                    -- operator-pending → thicker bar
}, ",")
