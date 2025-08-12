return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Prepend Vim logo to the mode display
      opts.sections.lualine_a = {
        { "mode", icon = "" }, -- Nerd Font Vim icon
      }
    end,
  },
}
