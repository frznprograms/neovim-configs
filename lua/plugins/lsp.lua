return {
  -- LSP: Point Pyright at "./.venv" so imports/types match your project env
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Python
        ruff = {},
        pyright = {
          settings = {
            python = {
              venvPath = ".",
              venv = ".venv",
            },
          },
        },

        -- C/C++
        clangd = {},

        -- Rust
        rust_analyzer = {},

        -- JavaScript / TypeScript / React (supports .js, .ts, .jsx, .tsx)
        tsserver = {
          -- You can add settings or leave empty
        },

        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
      },
    },
  },
  -- Ensure tools are installed via Mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      for _, pkg in ipairs({
        -- Python
        "pyright",
        "ruff",
        "debugpy",
        -- C/C++
        "clangd",
        -- Rust
        "rust-analyzer",
        -- JS/TS/React
        "tsserver",
        -- Lua
        "lua-language-server",
      }) do
        if not vim.tbl_contains(opts.ensure_installed, pkg) then
          table.insert(opts.ensure_installed, pkg)
        end
      end
    end,
  },
}
