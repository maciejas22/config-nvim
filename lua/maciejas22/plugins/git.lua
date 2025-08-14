return {
  {
    "echasnovski/mini-git",
    version = "*",
    main = "mini.git",
    event = "VeryLazy",
    keys = {
      {
        "<leader>gb",
        function()
          vim.cmd("vertical Git blame -- %")
        end,
        desc = "Git Blame (mini-git)",
      },
    },
    config = function()
      require("mini.git").setup({})
      local align_blame = function(au_data)
        if au_data.data.git_subcommand ~= "blame" then
          return
        end

        local win_src = au_data.data.win_source
        vim.wo.wrap = false
        vim.fn.winrestview({ topline = vim.fn.line("w0", win_src) })
        vim.api.nvim_win_set_cursor(0, { vim.fn.line(".", win_src), 0 })

        vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
      end

      local au_opts = { pattern = "MiniGitCommandSplit", callback = align_blame }
      vim.api.nvim_create_autocmd("User", au_opts)
    end,
  },
  {
    "echasnovski/mini.diff",
    version = "*",
    keys = {
      {
        "<leader>go",
        function()
          require("mini.diff").toggle_overlay(0)
        end,
        desc = "Toggle mini.diff overlay",
      },
    },
    opts = {
      view = {
        style = "sign",
        signs = {
          add = "▎",
          change = "▎",
          delete = "",
        },
      },
    },
  },
}
