return {
  "ibhagwan/fzf-lua",
  enabled = true,
  dependencies = { "mini.icons" },
  keys = {
    {
      "<leader>gb",
      function()
        require("fzf-lua").lgrep_curbuf()
      end,
      desc = "Fuzzily search in current buffer",
    },
    {
      "<leader>gW",
      function()
        require("fzf-lua").grep_cWORD({ hidden = true })
      end,
      desc = "Fuzzily search current WORD",
    },
    {
      "<leader>gw",
      function()
        require("fzf-lua").grep_cword({ hidden = true })
      end,
      desc = "Fuzzily search current word",
    },
    {
      "<leader>g/",
      function()
        require("fzf-lua").live_grep({ hidden = true })
      end,
      desc = "Fuzzily search in current project",
    },
    {
      "<leader>D",
      function()
        require("fzf-lua").diagnostics_document()
      end,
      desc = "Show buffer diagnostics",
    },
    {
      "<leader>fx",
      function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Fuzzily find Neovim config",
    },
    {
      "<leader>faf",
      function()
        require("fzf-lua").files({ hidden = true, no_ignore = true })
      end,
      desc = "Fuzzily find all files",
    },
    {
      "<leader>ff",
      function()
        require("fzf-lua").files({ hidden = true })
      end,
      desc = "Fuzzily find files",
    },
    {
      "<leader>fb",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Find open buffers",
    },
    {
      "<leader>fr",
      function()
        require("fzf-lua").oldfiles()
      end,
      desc = "Fuzzily find recent files",
    },
    -- I already have fr for oldfiles, so I am using fzr for this kind of like
    -- [fz]f [r]esume
    {
      "<leader>fzr",
      function()
        require("fzf-lua").resume()
      end,
      desc = "Fzf resume previous search",
    },
    {
      "<leader>fh",
      function()
        require("fzf-lua").help_tags()
      end,
      desc = "Find help documentation",
    },
    {
      "<leader>fk",
      function()
        require("fzf-lua").keymaps({
          -- show_details = false,
          winopts = {
            preview = { hidden = true },
          },
        })
      end,
      desc = "Find keymaps",
    },
    {
      "<leader>fm",
      function()
        require("fzf-lua").marks()
      end,
      desc = "Find marks",
    },
    {
      "<leader>xw",
      function()
        require("fzf-lua").diagnostics_workspace()
      end,
      desc = "View the project diagnostics",
    },
    {
      "<leader>xd",
      function()
        require("fzf-lua").diagnostics_document()
      end,
      desc = "View the document diagnostics",
    },
    -- making it gW to match gO for document symbols
    {
      "gW",
      function()
        require("fzf-lua").lsp_live_workspace_symbols()
      end,
      desc = "View the workspace symbols",
    },
    -- gO is by default, I want to use fzf-lua version one
    {
      "gO",
      function()
        require("fzf-lua").lsp_document_symbols()
      end,
      desc = "View the document symbols",
    },
    -- gra is by default for code actions. Overriding it to use fzf-lua
    {
      "gra",
      function()
        require("fzf-lua").lsp_code_actions({
          winopts = {
            preview = { hidden = true },
            relative = "cursor",
            row = 1.01,
            col = 0,
            width = 0.4,
            height = 0.2,
          },
        })
      end,
      desc = "View the code actions",
    },
    {
      "grt",
      function()
        require("fzf-lua").lsp_typedefs()
      end,
      desc = "View the type definitions",
    },
    {
      "grd",
      function()
        require("fzf-lua").lsp_definitions()
      end,
      desc = "View the definitions",
    },
    {
      "gri",
      function()
        require("fzf-lua").lsp_implementations()
      end,
      desc = "View the implementations",
    },
    {
      "grr",
      function()
        require("fzf-lua").lsp_references()
      end,
      desc = "View the references",
    },
    {
      -- This is the default nvim binding, which I am overriding here.
      "z=",
      function()
        require("fzf-lua").spell_suggest({
          winopts = {
            relative = "cursor",
            row = 1.01,
            col = 0,
            width = 0.2,
            height = 0.2,
          },
        })
      end,
      desc = "Spelling suggestions (Overriden default z=)",
    },
    {
      "<leader><tab>",
      function()
        require("fzf-lua").builtin()
      end,
      desc = "View FZF-lua options",
    },
    {
      "<leader>fp",
      function()
        require("fzf-lua").zoxide()
      end,
      desc = "Switch between multiple recent directories (not necessarily a project)",
    },
  },
  opts = {
    oldfiles = {
      include_current_session = true,
    },
    previewers = {
      builtin = {
        -- fzf-lua is very fast, but it really struggled to preview a couple files
        -- in a repo. Those files were very big JavaScript files (1MB, minified, all on a single line).
        -- It turns out it was Treesitter having trouble parsing the files.
        -- With this change, the previewer will not add syntax highlighting to files larger than 100KB
        -- (Yes, I know you shouldn't have 100KB minified files in source control.)
        syntax_limit_b = 1024 * 100, -- 100KB
      },
    },
    winopts = {
      preview = { default = "bat" },
    },
    manpages = { previewer = "man_native" },
    helptags = { previewer = "help_native" },
    lsp = { code_actions = { previewer = "codeaction_native" } },
    tags = { previewer = "bat" },
    btags = { previewer = "bat" },
    fzf_opts = { ["--cycle"] = true },
    files = {
      cmd = os.getenv("FZF_DEFAULT_COMMAND"),
      cwd_prompt = true,
      cwd_prompt_shorten_len = 1,
    },
    grep = {
      git_icons = false,
      exec_empty_query = true,
    },
    keymap = {
      fzf = {
        -- mimic the telescope behavior
        ["ctrl-q"] = "select-all+accept",
        ["ctrl-d"] = "preview-page-down",
        ["ctrl-u"] = "preview-page-up",
        ["f4"] = "toggle-preview",
        ["f3"] = "toggle-preview-wrap",
      },
    },
  },
}
