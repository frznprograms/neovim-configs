return {
  { "mason-org/mason-lspconfig.nvim", opts = { ensure_installed = { "gopls" } } },
  { "mason-org/mason.nvim", opts = { ensure_installed = { "goimports", "gofumpt" } } },
  {
    "neovim/nvim-lspconfig",
    ft = "go",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.gopls = {
        settings = { gopls = { gofumpt = true, analyses = { unusedparams = true } } }, -- enable gofumpt, etc.
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    ft = "go",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.go = { "goimports" }
    end,
  },
}
