return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>fF",
      function()
        require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() })
      end,
      desc = "Find Files (cwd)",
    },
    {
      "<leader>fG",
      function()
        require("telescope.builtin").live_grep({ cwd = vim.fn.getcwd() })
      end,
      desc = "Grep (cwd)",
    },
  },
}
