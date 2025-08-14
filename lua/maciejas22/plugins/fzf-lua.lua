return {
  "ibhagwan/fzf-lua",
  enabled = true,
  dependencies = { "mini.icons" },
  keys = function()
    local function fzf_call(fn_name, opts)
      return function()
        require("fzf-lua")[fn_name](opts)
      end
    end

    return {
      { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
      { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },

      { "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
      { "<leader>/", fzf_call("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader><space>", fzf_call("files"), desc = "Find Files (Root Dir)" },

      -- find
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>fc", fzf_call("files", { cwd = vim.fn.stdpath("config") }), desc = "Find Config File" },
      { "<leader>ff", fzf_call("files"), desc = "Find Files (Root Dir)" },
      { "<leader>fF", fzf_call("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      { "<leader>fR", fzf_call("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },

      -- git
      { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },

      -- search
      { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
      { "<leader>sg", fzf_call("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>sG", fzf_call("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
      { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
      { "<leader>sw", fzf_call("grep_cword"), desc = "Word (Root Dir)" },
      { "<leader>sW", fzf_call("grep_cword", { root = false }), desc = "Word (cwd)" },
      { "<leader>sw", fzf_call("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
      { "<leader>sW", fzf_call("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
      { "<leader>uC", fzf_call("colorschemes"), desc = "Colorscheme with Preview" },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Goto Symbol" },
      { "<leader>sS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Goto Symbol (Workspace)" },

      -- lsp
      { "gd", "<cmd>FzfLua lsp_definitions<cr>", desc = "Goto Definition" },
      { "gr", "<cmd>FzfLua lsp_references<cr>", desc = "References", nowait = true },
      { "gi", "<cmd>FzfLua lsp_implementations<cr>", desc = "Goto Implementation" },
      { "gy", "<cmd>FzfLua lsp_typedefs<cr>", desc = "Goto T[y]pe Definition" },
      { "ca", "<cmd>FzfLua lsp_code_actions<cr>", desc = "View the code actions" },
    }
  end,
  opts = function()
    local fzf = require("fzf-lua")
    local actions = fzf.actions

    return {
      "default-title",
      fzf_opts = {
        ["--no-scrollbar"] = true,
        ["--cycle"] = true,
      },
      defaults = {
        formatter = "path.dirname_first",
      },
      lsp = { code_actions = { previewer = "codeaction_native" } },

      winopts = {
        preview = { default = "bat" },
      },

      files = {
        cwd_prompt = false,
        hidden = false,
        no_ignore = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      grep = {
        hidden = false,
        no_ignore = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
          ["ctrl-d"] = "preview-page-down",
          ["ctrl-u"] = "preview-page-up",
          ["f4"] = "toggle-preview",
          ["f3"] = "toggle-preview-wrap",
        },
      },
    }
  end,
}
