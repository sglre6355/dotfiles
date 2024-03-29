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
require("mason-lspconfig").setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })
    end,
})

-- Linter
require("lint").linters_by_ft = {
    python = { "flake8" },
}

-- Formatter
local formatter_util = require("formatter.util")

function prettier()
    return {
        exe = "~/.local/share/nvim/mason/bin/prettier",
        args = {
            "--tab-width 4",
            "--html-whitespace-sensitivity ignore",
            "--stdin-filepath",
            formatter_util.escape_path(formatter_util.get_current_buffer_file_path()),
        },
        stdin = true,
    }
end

require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
        },
        html = { prettier },
        javascript = { prettier },
        json = { prettier },
        python = {
            require("formatter.filetypes.python").black,
            require("formatter.filetypes.python").isort,
        },
        lua = {
            require("formatter.filetypes.lua").stylua,
        },
    },
})

-- Treesitter
require("nvim-treesitter.configs").setup({
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

vim.diagnostic.config({ update_in_insert = true })

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
