return {
  -- Ensure Python LSP and tools are installed
  {
    "mason-org/mason-lspconfig.nvim", -- Mason extension for LSP
    opts = { ensure_installed = { "pyright", "ruff" } },
  },
  { "mason-org/mason.nvim", opts = { ensure_installed = { "ruff" } } }, -- also install formatters
  -- LSP configurations for Python
  {
    "neovim/nvim-lspconfig",
    ft = "python",
    opts = function(_, opts)
      local lspconfig = require("lspconfig")
      -- Set up Pyright
      opts.servers = opts.servers or {}
      opts.servers.pyright = {
        settings = {
          pyright = { disableOrganizeImports = true }, -- use Ruff for imports
          python = {
            analysis = { typeCheckingMode = "basic" },
          },
        },
        on_attach = function(client, bufnr)
          -- Disable LSP formatting to avoid conflicts (Pyright doesn't format anyway)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }
      -- Set up Ruff LSP (for linting & quick fixes)
      opts.servers.ruff = {
        init_options = { settings = { logLevel = "error" } },
        on_attach = function(client, bufnr)
          client.server_capabilities.hoverProvider = false -- disable Ruff hover, use Pyright’s
          -- Disable any formatting (Ruff LSP provides organize imports via code action, not full formatting)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }
    end,
  },
  -- Conform.nvim formatting for Python
  {
    "stevearc/conform.nvim",
    ft = "python",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      -- Chain ruff and isort (ruff for lint fixes, isort for imports, then Ruff formatter):
      opts.formatters_by_ft.python = { "ruff_fix", "ruff_format", "ruff_organize_imports" }
      -- Alternatively, if using isort + Black:
      -- opts.formatters_by_ft.python = { "isort", "black" }
    end,
  },
}
