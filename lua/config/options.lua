vim.g.mapleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true

opt.splitbelow = true
opt.splitright = true

opt.scrolloff = 8

vim.opt.clipboard = "unnamedplus"

vim.opt.guicursor = ""

vim.opt.fillchars:append({
  eob = " ",
})

--for horizontal navigation
vim.keymap.set("n", "<Tab>", "<C-w>w", { desc = "Next window" })


--color for statusbar
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "StatusLine", {
            fg = "#ffffff",
            bg = "#00001B",
            bold = true,
        })

        vim.api.nvim_set_hl(0, "StatusLineNC", {
            fg = "#a0a0a0",
            bg = "#000066",
        })
    end,
})
