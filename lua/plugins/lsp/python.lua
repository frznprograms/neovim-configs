return {
  -- Ruff handles both formatting and import sorting (replaces isort)
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.python = { "ruff_format", "ruff_organize_imports" }
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "basic", -- reduce false positives
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                -- let ruff handle linting; basedpyright focuses on types
                diagnosticSeverityOverrides = {
                  reportUnusedImport = "none",
                  reportUnusedVariable = "none",
                },
              },
            },
          },
        },
        ruff = {
          -- ruff LSP handles linting + code actions
          -- formatting is delegated to conform.nvim above
          on_attach = function(client, _)
            -- disable ruff's hover so basedpyright provides type info
            client.server_capabilities.hoverProvider = false
          end,
        },
      },
    },
  },
}
