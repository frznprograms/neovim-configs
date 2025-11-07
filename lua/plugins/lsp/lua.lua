return {
  { "mason-org/mason-lspconfig.nvim", opts = { ensure_installed = { "lua_ls" } } },
  { "mason-org/mason.nvim", opts = { ensure_installed = { "stylua" } } },
  {
    "neovim/nvim-lspconfig",
    ft = "lua",
    opts = function(_, opts)
      local lspconfig = require("lspconfig")
      opts.servers = opts.servers or {}
      opts.servers.lua_ls = {
        settings = { -- Neovim runtime path and formatting settings for Lua LS
          Lua = {
            workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
            completion = { callSnippet = "Replace" },
            format = { enable = false }, -- disable built-in formatter
          },
        },
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false -- ensure disabled
        end,
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    ft = "lua",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.lua = { "stylua" } -- use Stylua for Lua files
    end,
  },
}
