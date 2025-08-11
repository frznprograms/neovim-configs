return {
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 8000, -- stay longer
      stages = "fade", -- smooth
      render = "default",
      top_down = false, -- show at top-right
      max_width = 60,
    },
    init = function()
      vim.notify = require("notify")
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = { lsp_doc_border = true },
      lsp = { progress = { enabled = true } },
      messages = { view_search = false },
      -- optional: route annoying "written" messages to mini view
      routes = {
        { filter = { event = "msg_show", kind = "search_count" }, view = "mini" },
        { filter = { event = "msg_show", find = "written" }, view = "mini" },
      },
    },
  },
}
