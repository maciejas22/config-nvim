vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end,
})

vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/folke/tokyonight.nvim",
    "https://github.com/echasnovski/mini.icons",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/mrjones2014/smart-splits.nvim",
    "https://github.com/szw/vim-maximizer",
    "https://github.com/echasnovski/mini.statusline",
    "https://github.com/echasnovski/mini.surround",
    "https://github.com/echasnovski/mini.pairs",
    "https://github.com/echasnovski/mini.clue",
    "https://github.com/echasnovski/mini-git",
    "https://github.com/echasnovski/mini.diff",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main", name = "nvim-treesitter" },
    "https://github.com/windwp/nvim-ts-autotag",
    "https://github.com/folke/lazydev.nvim",
    { src = "https://github.com/saghen/blink.cmp", version = "1.*" },
    "https://github.com/antosha417/nvim-lsp-file-operations",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/mfussenegger/nvim-lint",
    "https://github.com/olimorris/codecompanion.nvim",
})

require("tokyonight").setup({ style = "night" })
vim.cmd.colorscheme("tokyonight")

require("mini.icons").setup()

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
require("oil").setup({
    view_options = {
        show_hidden = true,
    },
})

local function fzf_call(fn_name, opts)
    return function()
        require("fzf-lua")[fn_name](opts)
    end
end

vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", fzf_call("files", { cwd = vim.fn.stdpath("config") }), { desc = "Find Config File" })
vim.keymap.set("n", "<leader>ff", fzf_call("files"), { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>fF", fzf_call("files", { root = false }), { desc = "Find Files (cwd)" })
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua git_files<cr>", { desc = "Find Files (git-files)" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent" })
vim.keymap.set("n", "<leader>fR", fzf_call("oldfiles", { cwd = vim.uv.cwd() }), { desc = "Recent (cwd)" })

vim.keymap.set("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "Commits" })
vim.keymap.set("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "Status" })

vim.keymap.set("n", '<leader>s"', "<cmd>FzfLua registers<cr>", { desc = "Registers" })
vim.keymap.set("n", "<leader>sa", "<cmd>FzfLua autocmds<cr>", { desc = "Auto Commands" })
vim.keymap.set("n", "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", { desc = "Buffer" })
vim.keymap.set("n", "<leader>sc", "<cmd>FzfLua command_history<cr>", { desc = "Command History" })
vim.keymap.set("n", "<leader>sC", "<cmd>FzfLua commands<cr>", { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", { desc = "Document Diagnostics" })
vim.keymap.set("n", "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<leader>sg", fzf_call("live_grep"), { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>sG", fzf_call("live_grep", { root = false }), { desc = "Grep (cwd)" })
vim.keymap.set("n", "<leader>sht", "<cmd>FzfLua help_tags<cr>", { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", "<cmd>FzfLua highlights<cr>", { desc = "Search Highlight Groups" })
vim.keymap.set("n", "<leader>sj", "<cmd>FzfLua jumps<cr>", { desc = "Jumplist" })
vim.keymap.set("n", "<leader>sk", "<cmd>FzfLua keymaps<cr>", { desc = "Key Maps" })
vim.keymap.set("n", "<leader>sl", "<cmd>FzfLua loclist<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>sM", "<cmd>FzfLua man_pages<cr>", { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sm", "<cmd>FzfLua marks<cr>", { desc = "Jump to Mark" })
vim.keymap.set("n", "<leader>sR", "<cmd>FzfLua resume<cr>", { desc = "Resume" })
vim.keymap.set("n", "<leader>sq", "<cmd>FzfLua quickfix<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>sw", fzf_call("grep_cword"), { desc = "Word (Root Dir)" })
vim.keymap.set("n", "<leader>sW", fzf_call("grep_cword", { root = false }), { desc = "Word (cwd)" })
vim.keymap.set("v", "<leader>sw", fzf_call("grep_visual"), { desc = "Selection (Root Dir)" })
vim.keymap.set("v", "<leader>sW", fzf_call("grep_visual", { root = false }), { desc = "Selection (cwd)" })
vim.keymap.set("n", "<leader>uC", fzf_call("colorschemes"), { desc = "Colorscheme with Preview" })
vim.keymap.set("n", "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Goto Symbol" })
vim.keymap.set("n", "<leader>sS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", { desc = "Goto Symbol (Workspace)" })

vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "Goto Definition" })
vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", { desc = "References", nowait = true })
vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<cr>", { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", "<cmd>FzfLua lsp_typedefs<cr>", { desc = "Goto T[y]pe Definition" })
vim.keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", { desc = "View the code actions" })

local fzf = require("fzf-lua")
local actions = fzf.actions
fzf.setup({
    "default-title",
    fzf_opts = {
        ["--no-scrollbar"] = true,
        ["--cycle"] = true,
    },
    lsp = { code_actions = { previewer = "codeaction_native" } },
    files = {
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
        },
    },
})

local smart_splits = require("smart-splits")
smart_splits.setup({})

vim.keymap.set("n", "<C-A-h>", smart_splits.resize_left)
vim.keymap.set("n", "<C-A-j>", smart_splits.resize_down)
vim.keymap.set("n", "<C-A-k>", smart_splits.resize_up)
vim.keymap.set("n", "<C-A-l>", smart_splits.resize_right)
vim.keymap.set("n", "<C-h>", smart_splits.move_cursor_left)
vim.keymap.set("n", "<C-j>", smart_splits.move_cursor_down)
vim.keymap.set("n", "<C-k>", smart_splits.move_cursor_up)
vim.keymap.set("n", "<C-l>", smart_splits.move_cursor_right)
vim.keymap.set("n", "<leader><leader>h", smart_splits.swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", smart_splits.swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", smart_splits.swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", smart_splits.swap_buf_right)
vim.keymap.set("n", "<leader>z", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" })

require("mini.statusline").setup()
require("mini.surround").setup({ n_lines = 100 })
require("mini.pairs").setup({ modes = { insert = true, command = true, terminal = false } })

local miniclue = require("mini.clue")
miniclue.setup({
    triggers = {
        { mode = { "n", "x" }, keys = "<Leader>" },
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
        { mode = "i", keys = "<C-x>" },
        { mode = { "n", "x" }, keys = "g" },
        { mode = { "n", "x" }, keys = "'" },
        { mode = { "n", "x" }, keys = "`" },
        { mode = { "n", "x" }, keys = '"' },
        { mode = { "i", "c" }, keys = "<C-r>" },
        { mode = "n", keys = "<C-w>" },
        { mode = { "n", "x" }, keys = "z" },
    },
    clues = {
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
})

require("mini.git").setup()
vim.keymap.set("n", "<leader>gb", function()
    vim.cmd("vertical Git blame -- %")
end, { desc = "Git Blame (mini-git)" })

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniGitCommandSplit",
    callback = function(au_data)
        if au_data.data.git_subcommand ~= "blame" then
            return
        end

        local win_src = au_data.data.win_source
        vim.wo.wrap = false
        vim.fn.winrestview({ topline = vim.fn.line("w0", win_src) })
        vim.api.nvim_win_set_cursor(0, { vim.fn.line(".", win_src), 0 })

        vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
    end,
})

require("mini.diff").setup({
    view = {
        style = "sign",
        signs = {
            add = "▎",
            change = "▎",
            delete = "",
        },
    },
})
vim.keymap.set("n", "<leader>go", function()
    require("mini.diff").toggle_overlay(0)
end, { desc = "Toggle mini.diff overlay" })

require("nvim-treesitter").install({
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
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "*" },
    callback = function()
        if vim.treesitter.get_parser(nil, nil, { error = false }) then
            vim.treesitter.start()
        end
    end,
})

require("nvim-ts-autotag").setup()

require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
})

require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
    },
    signature = { enabled = true },
    sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer", "codecompanion" },
        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
            },
        },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})

local lspconfig = require("lspconfig")
require("lsp-file-operations").setup()
lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
    capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("lsp-file-operations").default_capabilities()
    ),
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Smart rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, opts)

        opts.desc = "Go to next diagnostic"
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, opts)

        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
    end,
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
        },
        numhl = {},
    },
})

require("mason").setup()

require("mason-tool-installer").setup({
    ensure_installed = {
        "prettier",
        "biome",
        "stylua",
        "eslint_d",
        "golangci-lint",
    },
})

require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = {
        "astro",
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "gopls",
        "rust_analyzer",
    },
})

vim.g.autoformat = true
vim.keymap.set("n", "<leader>tf", function()
    vim.g.autoformat = not vim.g.autoformat
    print("Autoformat: " .. (vim.g.autoformat and "ON" or "OFF"))
end, { desc = "Toggle autoformat" })

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
        tex = { "tex-fmt" },
        plaintex = { "tex-fmt" },
        bib = { "bibtex-tidy" },
    },
    format_on_save = function()
        if not vim.g.autoformat then
            return
        end

        return {
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
        }
    end,
})

vim.keymap.set({ "n", "v" }, "<leader>fmt", function()
    conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end, { desc = "Format file or range (in visual mode)" })

vim.g.autolint = true
vim.keymap.set("n", "<leader>tl", function()
    vim.g.autolint = not vim.g.autolint
    print("Autolint: " .. (vim.g.autolint and "ON" or "OFF"))
end, { desc = "Toggle autolint" })

local lint = require("lint")
lint.linters_by_ft = {
    javascript = { "biomejs", "eslint" },
    typescript = { "biomejs", "eslint" },
    javascriptreact = { "biomejs", "eslint" },
    typescriptreact = { "biomejs", "eslint" },
    svelte = { "eslint" },
    python = { "pylint" },
    go = { "golangcilint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
        if not vim.g.autolint then
            return
        end
        lint.try_lint(nil, { ignore_errors = true })
    end,
})

vim.keymap.set("n", "<leader>ll", function()
    lint.try_lint(nil, { ignore_errors = false })
end, { desc = "Trigger linting for current file" })

require("codecompanion").setup({
    interactions = {
        chat = {
            adapter = "openai",
        },
        inline = {
            adapter = "openai",
        },
        cmd = {
            adapter = "openai",
        },
    },
})
