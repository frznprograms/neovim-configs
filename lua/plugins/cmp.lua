return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.window = {
      completion = cmp.config.window.bordered({
        winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      }),
      documentation = cmp.config.window.bordered(),
    }
    return opts
  end,
}
