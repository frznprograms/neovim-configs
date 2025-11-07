return {
  { "mason-org/mason-lspconfig.nvim", opts = { ensure_installed = { "clangd" } } },
  { "mason-org/mason.nvim", opts = { ensure_installed = { "clang-format" } } },
  {
    "neovim/nvim-lspconfig",
    ft = { "c", "cpp" },
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.clangd = {
        cmd = { "clangd", "--clang-tidy", "--completion-style=bundled" }, -- example flags
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    ft = { "c", "cpp" },
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.c = { "clang_format" }
      opts.formatters_by_ft.cpp = { "clang_format" }
    end,
  },
}
