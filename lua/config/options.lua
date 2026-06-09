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
