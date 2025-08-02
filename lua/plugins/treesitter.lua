return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "python",
      "c",
      "cpp",
      "rust",
      "markdown",
    })

    opts.highlight = { enable = true }
    opts.indent = { enable = false }
  end,
}
