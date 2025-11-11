return {
  -- Notify UI
  {
    "rcarriga/nvim-notify",
    lazy = true, -- let Noice load it when needed
    opts = {
      timeout = 3000, -- stay longer
      stages = "fade", -- smooth
      render = "default",
      top_down = false, -- show at top-right
      max_width = 60,
      background_colour = "#000000",
    },
  },
  --
  --   -- Noice (message router + LSP UI)
  --   {
  --     "folke/noice.nvim",
  --     event = "VeryLazy",
  --     dependencies = {
  --       "MunifTanjim/nui.nvim",
  --       "rcarriga/nvim-notify", -- make sure Notify is available
  --     },
  --     opts = {
  --       presets = { lsp_doc_border = true },
  --       lsp = { progress = { enabled = true } },
  --       messages = { view_search = false },
  --       routes = {
  --         { filter = { event = "msg_show", kind = "search_count" }, view = "mini" },
  --         { filter = { event = "msg_show", find = "written" }, view = "mini" },
  --       },
  --     },
  --   },
  -- }
}
