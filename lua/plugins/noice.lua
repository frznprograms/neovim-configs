return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = function(_, opts)
    opts.presets.lsp_doc_border = true
  end
}
