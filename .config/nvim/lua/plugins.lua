vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- package management
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use { 'ellisonleao/gruvbox.nvim' }

  -- transparency
  use { 'xiyaowong/nvim-transparent' }

  -- file finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
end)
