vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'nvim-lualine/lualine.nvim'
  require('lualine').setup()

  use 'nvim-treesitter/nvim-treesitter'

  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'

  use 'preservim/nerdtree'

  use 'ycm-core/YouCompleteMe'

  use 'marko-cerovac/material.nvim'
  vim.g.material_style = "darker"
  use 'ellisonleao/gruvbox.nvim'
  vim.cmd 'colorscheme gruvbox'
  vim.cmd('hi Normal guibg=None')
  vim.cmd('hi Normal ctermbg=None')
end)
