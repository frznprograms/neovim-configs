return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    filesystem = {
      -- keep Neo-tree's root synced with Neovim's cwd
      bind_to_cwd = true,
      -- optional: reveal and focus the current file automatically
      follow_current_file = { enabled = true },
      -- optional: enable file system watching if you want auto refresh
      -- use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        -- "u" to go up a directory
        ["u"] = function(state)
          local node = state.tree:get_node()
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end,
      },
    },
  },
  keys = {
    -- Toggle Neo-tree rooted at the *current* working directory
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({
          source = "filesystem",
          toggle = true,
          -- this is redundant when bind_to_cwd=true, but keeps the intent explicit
          dir = vim.fn.getcwd(),
        })
      end,
      desc = "Explorer Neo-tree (cwd)",
    },
    -- Optional: a separate key to open at project root if you still want that
    -- {
    --   "<leader>E",
    --   function()
    --     require("neo-tree.command").execute({
    --       source = "filesystem",
    --       toggle = true,
    --       dir = require("lazyvim.util").get_root(),
    --     })
    --   end,
    --   desc = "Explorer Neo-tree (project root)",
    -- },
  },
}
