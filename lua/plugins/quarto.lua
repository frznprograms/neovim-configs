return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        chunks = "curly", -- expect ```{python} style chunks
        languages = { "python" },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = { enabled = true },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten", -- send cells to Molten
        ft_runners = { python = "molten" },
        never_run = { "yaml" },
      },
    },
    config = function(_, opts)
      require("quarto").setup(opts)

      -- If we're editing a .md that actually contains Quarto/Myst-style curly chunks,
      -- treat it as Quarto so cell actions work.
      vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*.md",
        callback = function(args)
          local has_curly = false
          for i = 1, math.min(200, vim.api.nvim_buf_line_count(args.buf)) do
            local line = vim.api.nvim_buf_get_lines(args.buf, i - 1, i, false)[1]
            if line and line:match("^%s*```%s*{[%w_%-]+") then
              has_curly = true
              break
            end
          end
          if has_curly then
            vim.bo[args.buf].filetype = "quarto"
          end
        end,
      })

      -- Make outputs and inline annotations visible
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "quarto", "markdown" },
        callback = function()
          vim.opt_local.conceallevel = 0
        end,
      })
    end,
  },
}
