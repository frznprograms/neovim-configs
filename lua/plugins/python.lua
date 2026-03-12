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
-- {
--   "neovim/nvim-lspconfig",
--   opts = {
--     servers = {
--       basedpyright = {
--         settings = {
--           basedpyright = {},
--           python = {
--             analysis = {
--               typeCheckingMode = "basic",
--               autoSearchPaths = true,
--               diagnosticMode = "workspace",
--             },
--             -- One of these patterns usually fixes venv package resolution:
--             -- venvPath = vim.fn.expand("~/.virtualenvs"), -- if you store envs here
--             venv = ".venv", -- if each project uses ./\.venv
--           },
--         },
--       },
--     },
--   },
-- }
