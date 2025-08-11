return {
  {
    "benlubas/molten-nvim",
    version = "^1.1.0", -- <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- Display images in outputs via image.nvim
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 30

      -- Make inline/virtual text visible (no hover needed)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "quarto", "markdown" },
        callback = function()
          vim.opt_local.conceallevel = 0
        end,
      })
    end,
  },
  {
    -- image backend for Molten outputs
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
}
