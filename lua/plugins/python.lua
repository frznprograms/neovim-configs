return {
  -- 1) Bring in LazyVim's Python extras (Pyright, Ruff, DAP, etc.)
  { import = "lazyvim.plugins.extras.lang.python" },

  -- 2) venv-selector: lets you pick & switch manually
  {
    "linux-cultist/venv-selector.nvim",
    cmd = { "VenvSelect", "VenvSelectCached", "VenvDeactivate" },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
      { "<leader>cV", "<cmd>VenvSelectCached<cr>", desc = "Select Last Python venv" },
      { "<leader>cD", "<cmd>VenvDeactivate<cr>", desc = "Deactivate Python venv" },
    },
    opts = {
      -- Minimal setup — no auto switching, no auto caching
      parents = 2,
      search = true,
      stay_on_this_env = false,
    },
    init = function()
      -- No VimEnter / DirChanged autocmds here.
      -- shell or :VenvSelect controls the active venv.
    end,
  },
}
