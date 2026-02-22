return {
    "neovim/nvim-lspconfig",
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    { "williamboman/mason-lspconfig.nvim", opts = {} },
    "tamago324/nlsp-settings.nvim",
    {
        "rmagatti/goto-preview",
        dependencies = { "rmagatti/logger.nvim" },
        event = "BufEnter",
        config = true,
    },
}
