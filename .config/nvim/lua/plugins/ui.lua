function gray(component)
    return { component, color = { fg = "#a2a3a6" } }
end

return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "ayu_dark",
            },
            sections = {
                lualine_c = { gray("filename") },
                lualine_x = { gray("encoding"), gray("fileformat"), gray("filetype") },
            },
        },
    },
    "onsails/lspkind.nvim",
    "nvim-tree/nvim-web-devicons",
}
