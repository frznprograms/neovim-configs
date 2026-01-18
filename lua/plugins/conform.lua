return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fo",
      function()
        require("conform").format({ async = false })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    -- Start empty; languages will extend this.
    formatters_by_ft = {},

    default_format_opts = {
      lsp_format = "fallback",
    },

    -- Customize formatters globally (optional)
    formatters = {
      shfmt = {
        append_args = { "-i", "2" },
      },
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
