return {
  "folke/noice.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = function(_, opts)
    opts.cmdline = {
      enabled = true,
      view = "cmdline_popup", -- use "cmdline" instead to render at bottom
    }
    opts.presets = opts.presets or {}
    opts.presets.lsp_doc_border = true
  end,
}
