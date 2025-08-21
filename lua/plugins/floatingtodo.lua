return {
  "vimichael/floatingtodo.nvim",
  main = "floatingtodo", -- tells Lazy which module exposes setup()
  opts = {
    target_file = "~/notes/todo.txt",
    border = "rounded",
    width = 0.8,
    height = 0.8,
    position = "center",
  },
  cmd = { "Td" }, -- lazy-load when you run :Td
}
