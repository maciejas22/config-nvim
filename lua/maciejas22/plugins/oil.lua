return {
  "stevearc/oil.nvim",
  dependencies = { { "mini.icons", opts = {} } },
  lazy = false,
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    view_options = {
      show_hidden = true,
    },
    win_options = {
      winbar = "%#@attribute.builtin#%{substitute(v:lua.require('oil').get_current_dir(), '^' . $HOME, '~', '')}",
    },
    keymaps = {
      ["g?"] = { "actions.show_help", desc = "Show Help", mode = "n" },
      ["<CR>"] = { "actions.select", desc = "Select Item" },
      ["<leader>ev"] = { "actions.select", desc = "Open in Vertical Split", opts = { vertical = true } },
      ["<leader>eh"] = { "actions.select", desc = "Open in Horizontal Split", opts = { horizontal = true } },
      ["<leader>et"] = { "actions.select", desc = "Open in New Tab", opts = { tab = true } },
      ["<leader>ep"] = { "actions.preview", desc = "Preview File" },
      ["<leader>ec"] = { "actions.close", desc = "Close Oil", mode = "n" },
      ["<leader>er"] = { "actions.refresh", desc = "Refresh View" },
      ["-"] = { "actions.parent", desc = "Go to Parent Directory", mode = "n" },
      ["_"] = { "actions.open_cwd", desc = "Open Current Working Directory", mode = "n" },
      ["`"] = { "actions.cd", desc = "Change Directory", mode = "n" },
      ["~"] = { "actions.cd", desc = "Change Directory (Tab Scope)", opts = { scope = "tab" }, mode = "n" },
      ["gs"] = { "actions.change_sort", desc = "Change Sort Order", mode = "n" },
      ["gx"] = { "actions.open_external", desc = "Open with External Program" },
      ["g."] = { "actions.toggle_hidden", desc = "Toggle Hidden Files", mode = "n" },
      ["g\\"] = { "actions.toggle_trash", desc = "Toggle Trash View", mode = "n" },
    },
  },
}
