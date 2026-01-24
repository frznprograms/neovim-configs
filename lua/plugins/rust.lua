return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "rust-analyzer",
      })
    end,
  },

  -- rust-analyzer LSP setup
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
      },
    },
  },

  -- Formatting via conform.nvim
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt" },
      },
      -- This is the key part: autoformat on save
      format_on_save = {
        timeout_ms = 1500,
        lsp_fallback = true,
      },
    },
  },
}
