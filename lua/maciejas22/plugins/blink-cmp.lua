return {
  "saghen/blink.cmp",
  version = "*",

  opts = {
    keymap = {
      preset = "default",

      ["<C-k>"] = { "select_prev" },
      ["<C-j>"] = { "select_next" },
      ["<C-b>"] = { "scroll_documentation_up" },
      ["<C-f>"] = { "scroll_documentation_down" },
      ["<CR>"] = { "accept", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    signature = { enabled = true },

    fuzzy = { implementation = "prefer_rust_with_warning" },

    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
