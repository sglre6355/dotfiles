vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
	-- Packer can manage itself
	use "wbthomason/packer.nvim"
	
    -- Neovim
	use("lambdalisue/fern.vim")
    use("lambdalisue/nerdfont.vim")
    use("lambdalisue/fern-renderer-nerdfont.vim")
	use("nvim-telescope/telescope.nvim")
	use("nvim-lua/plenary.nvim")
	use("BurntSushi/ripgrep")
	use("nvim-tree/nvim-web-devicons")
	use("nvim-treesitter/nvim-treesitter")
	use("neoclide/coc.nvim")
	use("sharkdp/fd")
	use("nvim-lualine/lualine.nvim")
    use("tomasiser/vim-code-dark")
    
    -- Coding assistance
    use("github/copilot.vim")

    -- Git
    use { "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" }
    use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }
    use { "akinsho/git-conflict.nvim", tag = "*" }
    use("lewis6991/gitsigns.nvim")
    
    -- Python
    use("brentyi/isort.vim")
end)
