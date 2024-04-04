-- lazy.nvim is a package manager

-- set Leader to spacebar for things to work
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- install lazy if it isn't present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- load plugin specs from the plugins folder
require("lazy").setup("plugins")

-- setup keybinds
local wk = require("which-key")
wk.register({
	["<Leader>la"] = { "<cmd>Lazy<CR>", "Open Lazy" },
})
