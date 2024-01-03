require("plugins")

require("lazy").setup("plugins")

function gray(component)
	return { component, color = { fg = "#a2a3a6" } }
end

require("lualine").setup({
	options = {
		theme = "ayu_dark",
	},
	sections = {
		lualine_c = { gray("filename") },
		lualine_x = { gray("encoding"), gray("fileformat"), gray("filetype") },
	},
})

require("nvim-treesitter.configs").setup({
	autotag = {
		enable = true,
	},
	highlight = {
		enable = true,
	},
})

vim.api.nvim_command("colorscheme codedark")

require("neogit").setup()
require("git-conflict").setup()
require("gitsigns").setup()

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

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
		})
	end,
})

vim.diagnostic.config({ update_in_insert = true })

require("lint").linters_by_ft = {
	python = { "flake8" },
}

local util = require("formatter.util")

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
		html = {
			function()
				return {
					exe = "~/.local/share/nvim/mason/bin/prettier",
					args = {
						"--tab-width 4",
						"--html-whitespace-sensitivity ignore",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
					},
					stdin = true,
				}
			end,
		},
		python = {
			require("formatter.filetypes.python").black,
			require("formatter.filetypes.python").isort,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
	},
})

require("copilot").setup({
	suggestion = {
		enabled = false,
	},
})

-- Disable Github Copilot for AtCoder codes
if string.find(vim.api.nvim_buf_get_name(0), "AtCoder") then
	vim.api.nvim_command("autocmd VimEnter * Copilot disable")
end

vim.o.termguicolors = true

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

function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<C-f>", ":Telescope find_files<CR>", { silent = true })
