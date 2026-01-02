-- load rose-pine theme
return {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = {
    variant = "main",
    dark_variant = "main",
    dim_inactive_windows = false,
    extend_background_behind_borders = true,
    enable = {
      terminal = true,
      legacy_highlights = true,
      migrations = true,
    },
    styles = {
      bold = true,
      italic = true,
      transparency = true,
    },
  },
  config = function(_, opts) -- Added opts parameter
    require("rose-pine").setup(opts) -- Setup the plugin with your options
    vim.cmd("colorscheme rose-pine") -- Apply the colorscheme
  end,
}
