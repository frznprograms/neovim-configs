return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function()
      -- === Your ASCII header ===
      local header = [[
 ______   ______      ______  ___   __    ______   ______   ______   ______
/_____/\ /_____/\    /_____/\/__/\ /__/\ /_____/\ /_____/\ /_____/\ /_____/\
\::::_\/_\:::_ \ \   \:::__\/\::\_\\  \ \\:::__\/ \:::_ \ \\:::_ \ \\::::_\/_
 \:\/___/\\:(_) ) )_    /: /  \:. `-\  \ \\:\ \  __\:\ \ \ \\:\ \ \ \\:\/___/\
  \:::._\/ \: __ `\ \  /::/___ \:. _    \ \\:\ \/_/\\:\ \ \ \\:\ \ \ \\::___\/_
   \:\ \    \ \ `\ \ \/_:/____/\\. \`-\  \ \\:\_\ \ \\:\_\ \ \\:\/.:| |\:\____/\
    \_\/     \_\/ \_\/\_______\/ \__\/ \__\/ \_____\/ \_____\/ \____/_/ \_____\/
      ]]

      local function longest_line_len(s)
        local max = 0
        for line in s:gmatch("([^\n]*)\n?") do
          local n = vim.fn.strdisplaywidth(line)
          if n > max then
            max = n
          end
        end
        return max
      end

      -- Make the dashboard wide enough for the header (with a little extra for the key hints)
      local DASHBOARD_WIDTH = math.max(70, longest_line_len(header) + 6)

      -- Choose a “fetch”/colors command that actually exists to avoid zsh errors (see below)
      local fetch_cmd = (vim.fn.executable("colorscript") == 1 and "colorscript -e square")
          or (vim.fn.executable("fastfetch") == 1 and "fastfetch --logo small")
          or (vim.fn.executable("neofetch") == 1 and "neofetch")
          or nil

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
          width = DASHBOARD_WIDTH,
          row = nil,
          col = nil,
          pane_gap = 4,

          -- If you prefer to hide the orange key hints, set this to nil:
          -- autokeys = nil,
          autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

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
            header = header,
          },

          formats = {
            icon = function(item)
              return { item.icon, width = 2, hl = "icon" }
            end,
            footer = { "%s", align = "center" },
            header = { "%s", align = "center" },
            file = function(item, ctx)
              local fname = vim.fn.fnamemodify(item.file, ":~")
              fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
              if #fname > ctx.width then
                local dir = vim.fn.fnamemodify(fname, ":h")
                local file = vim.fn.fnamemodify(fname, ":t")
                if dir and file then
                  file = file:sub(-(ctx.width - #dir - 2))
                  fname = dir .. "/…" .. file
                end
              end
              local dir, file = fname:match("^(.*)/(.+)$")
              return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
            end,
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
