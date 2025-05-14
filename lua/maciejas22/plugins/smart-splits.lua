return {
  "mrjones2014/smart-splits.nvim",
  config = function()
    local smart_splits = require("smart-splits")
    smart_splits.setup({})

    -- vim.keymap.set("n", "<S-h>", require("smart-splits").resize_left)
    -- vim.keymap.set("n", "<S-j>", require("smart-splits").resize_down)
    -- vim.keymap.set("n", "<S-k>", require("smart-splits").resize_up)
    -- vim.keymap.set("n", "<S-l>", require("smart-splits").resize_right)
    -- moving between splits
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
    -- swapping buffers between windows
    vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
    vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
    vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
    vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
  end,
}
