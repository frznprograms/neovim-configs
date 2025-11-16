return {
  {
    "mrcjkb/rustaceanvim",
    version = "latest",

    ft = { "rust" },

    config = function()
      vim.g.rustaceanvim = {
        tools = {
          -- Disable noisy automatic features
          hover_actions = { auto_focus = false },
          inlay_hints = {
            auto = false, -- disable auto inlay hints
          },
        },

        server = {
          on_attach = function(client, bufnr)
            -- Disable LSP formatting (we use rustfmt via conform)
            client.server_capabilities.documentFormattingProvider = false
          end,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
              -- disable hover popups automatically
              hover = { enable = false },
              -- disable signature help popups automatically
              signatureHelp = { enable = false },
              inlayHints = { enable = false },
              diagnostics = {
                disabled = { "unresolved-proc-macro" },
              },
            },
          },
        },
      }
    end,
  },

  -- Formatting (rustfmt)
  {
    "stevearc/conform.nvim",
    ft = "rust",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.rust = { "rustfmt" }
    end,
  },
}
