-- ~/.config/nvim/lua/plugins/python.lua
-- LazyVim: Python setup with auto .venv activation and clean uv fallback.

-- Helpers (no vim.loop warnings; works on 0.9 and 0.10+)
local uv = vim.uv or vim.loop
local function path_sep()
  return package.config:sub(1, 1)
end
local function join(a, b)
  local sep = path_sep()
  if a:sub(-1) == sep then
    return a .. b
  end
  return a .. sep .. b
end

-- Compute the expected python binary inside a local .venv, cross‑platform.
local function venv_python_for(root)
  if not root or root == "" then
    return nil
  end
  local sep = path_sep()
  if sep == "\\" then
    -- Windows
    return join(join(join(root, ".venv"), "Scripts"), "python.exe")
  else
    -- POSIX
    return join(join(join(root, ".venv"), "bin"), "python")
  end
end

-- Try to find the current working directory (uv first, then Vim)
local function get_cwd()
  return (uv and uv.cwd and uv.cwd()) or vim.fn.getcwd()
end

-- Activate local .venv (if present) and set python host for providers/LSPs
local function activate_local_venv()
  local root = get_cwd()
  local py = venv_python_for(root)
  if py and vim.fn.executable(py) == 1 then
    -- Make Neovim's python host use the project venv (important for some plugins)
    vim.g.python3_host_prog = py

    -- Try to activate for the whole session (PATH, VIRTUAL_ENV) so terminals/tools inherit it.
    -- This uses venv-selector.nvim if available.
    pcall(function()
      -- ensure setup has run; safe to call repeatedly
      require("venv-selector").setup()
      -- activate() will pick the closest/last‑used venv; with .venv present it will select it.
      require("venv-selector").activate()
    end)
  end
end

return {
  -- 1) Bring in LazyVim's Python extras (Pyright, Ruff, DAP, etc.)
  { import = "lazyvim.plugins.extras.lang.python" },

  -- 2) venv‑selector: lets us auto/smart‑select the local .venv
  {
    "linux-cultist/venv-selector.nvim",
    cmd = { "VenvSelect", "VenvSelectCached", "VenvDeactivate" },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
      { "<leader>cV", "<cmd>VenvSelectCached<cr>", desc = "Select Last Python venv" },
    },
    opts = {
      -- Scan a bit upward for venvs, but we’ll prefer the local .venv via our autocmd below.
      parents = 2,
      search = true,
      stay_on_this_env = false,
    },
    init = function()
      -- Auto‑activate local .venv on startup and when changing directories.
      vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function()
          activate_local_venv()
        end,
      })
      vim.api.nvim_create_autocmd({ "DirChanged" }, {
        callback = function()
          activate_local_venv()
          -- If an LSP started before env settled, you can uncomment the next line:
          -- vim.cmd("LspRestart")
        end,
      })
    end,
  },

  -- 3) LSP: Point Pyright at "./.venv" so imports/types match your project env
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ruff LSP for linting/quickfixes (works without venv, but benefits from it)
        ruff = {},
        -- Pyright type checker
        pyright = {
          -- These settings make pyright look for a venv named ".venv" in your project root.
          settings = {
            python = {
              venvPath = ".", -- directory that contains the venv(s)
              venv = ".venv", -- the specific venv name to use
            },
          },
        },
      },
    },
  },

  -- 4) (Optional) Ensure tools are installed via Mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- pyright (LSP), ruff (linter/formatter), debugpy (debugger)
      for _, pkg in ipairs({ "pyright", "ruff", "debugpy" }) do
        if not vim.tbl_contains(opts.ensure_installed, pkg) then
          table.insert(opts.ensure_installed, pkg)
        end
      end
    end,
  },
}
