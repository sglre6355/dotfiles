require("plugins")

require("lazy").setup("plugins")

function gray(component)
    return {component, color={fg="#a2a3a6"}}
end

require("lualine").setup({
    options = {
        theme = "ayu_dark",
    },
    sections = {
        lualine_c = {gray("filename")},
        lualine_x = {gray("encoding"), gray("fileformat"), gray("filetype")},
    }
})

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true
    }
})

vim.api.nvim_command("colorscheme codedark")

require("neogit").setup()
require("git-conflict").setup()
require("gitsigns").setup()

-- Disable Github Copilot for AtCoder codes
if string.find(vim.api.nvim_buf_get_name(0), "AtCoder")  then
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

map("n", "<C-f>", ":Telescope find_files<CR>", {silent = true})
