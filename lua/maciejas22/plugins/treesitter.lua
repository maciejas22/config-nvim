return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    ---@class TSConfig
    opts = {
      ensure_installed = {
        "astro",
        "bash",
        "c",
        "css",
        "dockerfile",
        "gitignore",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "rust",
        "svelte",
        "sql",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
    config = function(_, opts)
      local alreadyInstalled = require("nvim-treesitter.config").get_installed()
      local parsersToInstall = vim
        .iter(opts.ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
      require("nvim-treesitter").install(parsersToInstall)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "*" },
        callback = function()
          -- remove error = false when nvim 0.12+ is default
          if vim.treesitter.get_parser(nil, nil, { error = false }) then
            vim.treesitter.start()
          end
        end,
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
}
