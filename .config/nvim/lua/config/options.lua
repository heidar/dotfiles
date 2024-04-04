-- this file contains all custom options

local set = vim.o

-- set the color scheme
vim.cmd.colorscheme("catppuccin")

-- wrapping
vim.wo.wrap = false

local options = {
	list = true, -- show empty characters
	listchars = "tab:‣ ,trail:·,nbsp:·,precedes:←,extends:→", -- set characters
	number = true, -- show line numbers
	relativenumber = true, -- show relative line numbers
	clipboard = "unnamedplus", -- copy to clipboard
	spelllang = "en", -- spellcheck language
	tabstop = 4, -- number of spaces a tab counts for
	softtabstop = 4, -- number of spaces a tab counts for
	shiftwidth = 4, -- set indentation width
	smartindent = true, -- turn on smartindent
	hlsearch = false, -- highlight all matches on previous search pattern
	smartcase = true, -- smart case
	scrolloff = 8, -- keep cursor off the bottom
	sidescrolloff = 8, -- keep cursor off the side
	signcolumn = "yes", -- always show signcolumn
	updatetime = 50, -- faster update time
	colorcolumn = "80", -- color 80th column
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
