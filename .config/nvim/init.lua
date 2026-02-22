-- Bootstrap for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- LSP
vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
vim.lsp.config("clangd", {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }, -- exclude "proto".
})

vim.lsp.config("rust-analyzer", {
    on_attach = on_attach,
    flags = lsp_flags,
    cmd = function()
        return vim.lsp.rpc.connect("127.0.0.1", 27631)
    end,
    init_options = {
        lspMux = {
            version = "1",
            method = "connect",
            server = "rust-analyzer",
        },
    },
})

-- Linter
require("lint").linters_by_ft = {
    dockerfile = { "hadolint" },
    gitcommit = { "commitlint" },
    go = { "golangcilint" },
    markdown = { "markdownlint" },
    python = { "flake8" },
    yaml = { "actionlint" },
}

vim.api.nvim_create_user_command("Lint", function()
    require("lint").try_lint()
end, {})

-- Formatter
local util = require("conform.util")

require("conform").setup({
    formatters = {
        rustfmt = {
            args = function(self, ctx)
                local args = { "+nightly", "--emit=stdout" }
                local edition = util.parse_rust_edition(ctx.dirname) or self.options.default_edition
                table.insert(args, "--edition=" .. edition)
                return args
            end,
        },
        golangcilint = {
            command = "golangci-lint",
            args = {
                "fmt",
                "--stdin",
            },
        },
    },
    formatters_by_ft = {
        go = { "golangci-lint" },
        html = { "prettier" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
        markdown = { "markdownlint" },
        protobuf = { "buf" },
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
        sql = { "sql_formatter" },
        typst = { "typstyle" },
        xml = { "xmlformatter" },
        yaml = { "yamlfmt" },
    },
})

vim.api.nvim_create_user_command("Format", function()
    require("conform").format()
end, {})

-- Treesitter
require("nvim-treesitter.configs").setup({
    indent = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
    highlight = {
        enable = true,
    },
})

-- Autocompletion
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {},
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
                return vim_item
            end,
        }),
    },
})

cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        { name = "git" },
    }, {
        { name = "buffer" },
    }),
})

require("goto-preview").setup({
    default_mappings = true,
})

vim.g.ftplugin_sql_omni_key = ""

vim.g.codecompanion_auto_tool_mode = true
--vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-s>", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

-- Vim options
vim.o.mouse = "a"

vim.o.swapfile = false
vim.o.backup = false
vim.o.hidden = true

vim.o.number = true

vim.o.signcolumn = "yes"

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wrapscan = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
})

if os.getenv("TERM") ~= "linux" then
    vim.o.termguicolors = true
    vim.api.nvim_command("colorscheme flexoki-dark")
end

-- Shortcut key mapping
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<C-f>", ":Telescope find_files<CR>", { silent = true })
map("n", "<A-l>", ":Lint<CR>", { silent = true })
map("n", "<A-f>", ":Format<CR>", { silent = true })

vim.keymap.set("x", "p", '"0p', { silent = true })
