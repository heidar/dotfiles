-- this file contains all custom options

local set = vim.o

-- set the color scheme
vim.cmd.colorscheme("catppuccin")

-- show empty characters
set.list = true
set.listchars = "tab:‣ ,trail:·,nbsp:·,precedes:←,extends:→"
vim.cmd([[match errorMsg /\s\+$/]])

-- show relative line numbers
set.number = true
set.relativenumber = true

-- copy to clipboard
set.clipboard = "unnamedplus"

-- spellcheck language
set.spelllang = "en"

-- indentation settings
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.smartindent = true

-- search settings
set.hlsearch = false
set.incsearch = true
set.smartcase = true

-- keep cursor off the bottom
set.scrolloff = 8
set.sidescrolloff = 8
set.signcolumn = "yes"

-- faster update time
set.updatetime = 50

-- color 80th column
set.colorcolumn = "80"

-- wrapping
vim.wo.wrap = false
