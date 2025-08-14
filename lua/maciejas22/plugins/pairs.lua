return {
  "echasnovski/mini.pairs",
  version = "*",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    modes = { insert = true, command = true, terminal = false },
  },
}
