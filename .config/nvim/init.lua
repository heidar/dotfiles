require 'plugins'

-- variables for keybindings
local map = vim.api.nvim_set_keymap
options   = { noremap = true }

-- colorscheme
vim.opt.termguicolors = true
vim.o.background      = 'dark'
vim.cmd([[colorscheme gruvbox]])

-- transparency
require('transparent').setup({ enable = true })

-- leader
vim.g.mapleader = ' '

-- file finder
map('n', '<Leader>ff', '<cmd>Telescope find_files<cr>', options)
map('n', '<Leader>fb', '<cmd>Telescope buffers<cr>', options)
map('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>', options)
