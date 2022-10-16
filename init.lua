vim.wo.number = true
vim.wo.relativenumber = true
vim.cmd("set termguicolors")
vim.cmd("syntax on")

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4

local packer = require('packer')
local use = packer.use
packer.startup()

require('plugins')
