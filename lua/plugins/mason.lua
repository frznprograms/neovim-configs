-- Single source of truth for all Mason-managed tools.
-- On a fresh machine, open Neovim and run :Lazy sync to auto-install everything.
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- LSP servers
        "rust-analyzer",
        "pyright",
        "lua-language-server",
        "gopls",
        "clangd",
        "jsonls",

        -- Formatters
        "stylua",
        "ruff",
        "rustfmt",
        "gofumpt",
        "goimports",
        "clang-format",
        "prettier", -- json, yaml, markdown

        -- Extra language servers
        "yaml-language-server",
        "marksman", -- markdown
      })
    end,
  },
}
