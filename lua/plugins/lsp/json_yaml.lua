return {
  { "mason-org/mason-lspconfig.nvim", opts = { ensure_installed = { "jsonls", "yamlls" } } },
  { "mason-org/mason.nvim", opts = { ensure_installed = { "prettier" } } },
  {
    "neovim/nvim-lspconfig",
    ft = { "json", "yaml" },
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.jsonls = {
        settings = { json = { format = { enable = false }, schemas = require("schemastore").json.schemas() } },
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }
      opts.servers.yamlls = {
        settings = { yaml = { keyOrdering = false } }, -- example YAML LS setting
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    ft = { "json", "yaml", "yml" },
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.json = { "prettier" }
      opts.formatters_by_ft.yaml = { "prettier" }
      opts.formatters_by_ft.yml = { "prettier" }
    end,
  },
}
