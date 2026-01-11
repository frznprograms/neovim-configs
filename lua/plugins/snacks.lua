return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function()
      return {
        indent = {
          scope = { enabled = true },
        },
        scroll = { enabled = true },
        bigfile = { enabled = true },
        terminal = {
          win = {
            position = "bottom",
            border = "rounded",
            height = 0.60,
            -- width = 0.7,
            -- backdrop = 50,
            style = "minimal",
            relative = "editor",
            title = "Terminal",
            title_pos = "center",
          },
        },
        dashboard = {
          enabled = true,
          row = nil,
          col = nil,
          pane_gap = 4,

          -- If you prefer to hide the orange key hints, set this to nil:
          autokeys = nil,

          preset = {
            pick = nil,
            keys = {
              { icon = " ", key = "f", desc = "Find File",    action = ":lua Snacks.dashboard.pick('files')" },
              { icon = " ", key = "n", desc = "New File",     action = ":ene | startinsert" },
              { icon = " ", key = "g", desc = "Find Text",    action = ":lua Snacks.dashboard.pick('live_grep')" },
              { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
              {
                icon = " ",
                key = "c",
                desc = "Config",
                action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
              },
              { icon = " ", key = "s", desc = "Restore Session", section = "session" },
              { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
              { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
          },
          sections = {
            { section = "header" },

            { section = "keys", gap = 1, padding = 1 },
            { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
            { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },

            {
              pane = 2,
              icon = " ",
              title = "Git Status",
              section = "terminal",
              enabled = function()
                return (Snacks.git.get_root() ~= nil)
              end,
              cmd = "git status --short --branch --renames",
              height = 5,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            },

            { section = "startup" },
          },
        },
      }
    end,
    keys = {
      {
        "<leader>t",
        function()
          Snacks.terminal()
        end,
        desc = "Toggle Terminal",
      },
    },
  },
}
