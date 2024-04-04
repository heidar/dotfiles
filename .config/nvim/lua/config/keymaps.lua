-- this file contains custom keybinds

local wk = require("which-key")
local register = wk.register

-- normal mode
register({
	["<leader><leader>"] = { "<cmd>w<CR>", "Quick save" },

	["<Leader>sp"] = { "<cmd>setlocal spell!<CR>", "Toggle spellcheck" },

	["J"] = { "mzJ'z", "Append line below to current" },

	["<C-Up>"] = { ":resize +2<CR>", "Increase vertical size" },
	["<C-Down>"] = { ":resize -2<CR>", "Decrease vertical size" },
	["<C-Left>"] = { ":vertical resize -2<CR>", "Increase horizontal size" },
	["<C-Right>"] = { ":vertical resize +2<CR>", "Decrease horizontal size" },

	["<C-f>"] = { "<C-f>zz", "Page down" },
	["<C-b>"] = { "<C-b>zz", "Page up" },

	["n"] = { "nzzzv", "Next match" },
	["N"] = { "Nzzzv", "Previous match" },

	["<c-k>"] = { "<c-w><up>", "Move to window above" },
	["<c-j>"] = { "<c-w><down>", "Move to window below" },
	["<c-h>"] = { "<c-w><left>", "Move to window on left" },
	["<c-l>"] = { "<c-w><right>", "Move to window on right" },
})

-- visual mode
register({
	p = { [["_dP]], "Paste" },
	["J"] = { ":m '>+1<CR>gv=gv", "Move text up" },
	["K"] = { ":m '<-2<CR>gv=gv", "Move text down" },

	["<"] = { "<gv", "Decrease indentation" },
	[">"] = { ">gv", "Increase indentation" },
}, { mode = "v" })

-- visual block mode
register({
	["J"] = { ":m '>+1<CR>gv=gv", "Move text up" },
	["K"] = { ":m '<-2<CR>gv=gv", "Move text down" },
}, { mode = "x" })
