return {
	-- Neovim
	"nvim-telescope/telescope.nvim",
	"nvim-lua/plenary.nvim",
	"BurntSushi/ripgrep",
	"nvim-tree/nvim-web-devicons",
	"nvim-treesitter/nvim-treesitter",
	"sharkdp/fd",
	"nvim-lualine/lualine.nvim",
	"tomasiser/vim-code-dark",

	-- Autocompletion
	"hrsh7th/nvim-cmp",

	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",

	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",

	"onsails/lspkind.nvim",

	"windwp/nvim-ts-autotag",

	-- LSP
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"tamago324/nlsp-settings.nvim",

	-- Linter
	"mfussenegger/nvim-lint",

	-- Formatter
	"mhartington/formatter.nvim",

	-- Coding assistance
	"zbirenbaum/copilot.lua",

	-- Git
	{ "NeogitOrg/neogit", requires = "nvim-lua/plenary.nvim" },
	{ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	"lewis6991/gitsigns.nvim",

    -- LaTeX
    "lervag/vimtex",
}
