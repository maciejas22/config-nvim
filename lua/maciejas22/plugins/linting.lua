return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "biomejs", "eslint" },
      typescript = { "biomejs", "eslint" },
      javascriptreact = { "biomejs", "eslint" },
      typescriptreact = { "biomejs", "eslint" },
      svelte = { "biomejs", "eslint" },
      python = { "pylint" },
      go = { "golangcilint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint(nil, { ignore_errors = true })
      end,
    })

    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint(nil, { ignore_errors = false })
    end, { desc = "Trigger linting for current file" })
  end,
}
