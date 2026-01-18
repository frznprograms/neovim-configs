return {
  -- Add/override Conform formatters for Python
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.python = { "isort", "ruff" }
      -- opts.formatters_by_ft.python = { "isort", "ruff_format" }
    end,
  },

  -- Optional: python LSP tweaks
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                -- Example tweaks:
                -- typeCheckingMode = "basic",
                -- autoSearchPaths = true,
                -- diagnosticMode = "workspace",
              },
            },
          },
        },
      },
    },
  },
}
