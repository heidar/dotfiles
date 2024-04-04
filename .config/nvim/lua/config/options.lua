-- this file contains all custom options

-- set the color scheme
vim.cmd.colorscheme("catppuccin")

-- wrapping
vim.wo.wrap = false

local options = {
	number = true, -- show line numbers
	relativenumber = true, -- show relative line numbers
	clipboard = "unnamedplus", -- copy to clipboard
	spelllang = "en", -- spellcheck language
	tabstop = 2, -- number of spaces a tab counts for
	softtabstop = 2, -- number of spaces a tab counts for
	shiftwidth = 2, -- set indentation width
	expandtab = true, -- use spaces instead of tab characters
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
