return {
  dir = "~/Documents/plugins/ketchup_nvim/",
  name = "ketchup",
  dev = true,
  cmd = { "Ketchup" },
  opts = {},
  config = function(opts)
    require("ketchup").setup(opts)
  end
}
