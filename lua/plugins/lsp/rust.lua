return {
  { "mason-org/mason-lspconfig.nvim", opts = { ensure_installed = { "rust_analyzer" } } },
  {
    "neovim/nvim-lspconfig",
    ft = "rust",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" }, -- example: run clippy on save
            diagnostics = { disabled = { "unresolved-proc-macro" } },
          },
        },
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false -- disable rust-analyzer formatting
        end,
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    ft = "rust",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.rust = { "rustfmt" }
    end,
  },
}
