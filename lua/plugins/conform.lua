return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "black" }, -- Let conform use Black
      c = { "clang_format" }, -- Let conform use clang-format
      cpp = { "clang_format" },
      lua = { "stylua" }, -- Optional: Lua formatter
      javascript = { "prettier" }, -- Optional
      typescript = { "prettier" }, -- Optional
    },
    formatters = {
      clang_format = {
        command = "clang-format",
        args = { "--style={BasedOnStyle: llvm, IndentWidth: 4}" },
      },
      black = {
        command = "black",
        args = { "--quiet", "-" }, -- stdin mode
      },
    },
  },
}
