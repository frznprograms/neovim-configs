return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Your custom on_attach function to disable LSP formatting
      local function on_attach(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end

      -- Inject the on_attach override globally
      opts.on_attach = on_attach

      -- LSP server settings
      opts.servers = opts.servers or {}

      opts.servers.ruff = {}
      opts.servers.pyright = {
        settings = {
          python = {
            venvPath = ".",
            venv = ".venv",
          },
        },
      }
      opts.servers.clangd = {}
      opts.servers.rust_analyzer = {}
      opts.servers.tsserver = {}
      opts.servers.lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }
    end,
  },
}
