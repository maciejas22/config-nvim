return {
  "stevearc/conform.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        astro = { "biome", "prettier", stop_after_first = true, lsp_format = "fallback" },
        javascript = { "biome", "prettier", stop_after_first = true, lsp_format = "fallback" },
        typescript = { "biome", "prettier", stop_after_first = true, lsp_format = "fallback" },
        javascriptreact = { "biome", "prettier", stop_after_first = true, lsp_format = "fallback" },
        typescriptreact = { "biome", "prettier", stop_after_first = true, lsp_format = "fallback" },
        svelte = { "biome", "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "biome", "prettier", stop_after_first = true, lsp_format = "fallback" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        go = { "goimports", "gofmt" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
