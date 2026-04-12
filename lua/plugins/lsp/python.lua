return {
  -- Ruff handles both formatting and import sorting (replaces isort)
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.python = { "ruff" }
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic", -- reduce false positives
                autoSearchPaths = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
      },
    },
  },
}
