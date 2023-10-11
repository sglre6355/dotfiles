return {
    -- Neovim
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    "neoclide/coc.nvim",
    "sharkdp/fd",
    "nvim-lualine/lualine.nvim",
    "tomasiser/vim-code-dark",

    -- Coding assistance
    "github/copilot.vim",

    -- Git
    { "NeogitOrg/neogit", requires = "nvim-lua/plenary.nvim" },
    { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
    { "akinsho/git-conflict.nvim", version = "*", config = true },
    "lewis6991/gitsigns.nvim",

    -- Python
    "brentyi/isort.vim"
}
