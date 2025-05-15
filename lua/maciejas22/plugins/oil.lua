return {
  "stevearc/oil.nvim",
  dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
  lazy = false,
  config = function()
    local oil = require("oil")
    oil.setup({})

    local keymap = vim.keymap
    keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
