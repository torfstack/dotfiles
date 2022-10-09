vim.wo.number = true
vim.cmd("set termguicolors")
vim.cmd("syntax on")

local packer = require('packer')
local use = packer.use
packer.startup()

require('plugins')
