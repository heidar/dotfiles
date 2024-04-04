-- call lazygit from within neovim

return {
	"kdheepak/lazygit.nvim",
	event = "VeryLazy",
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- keybindings
		local wk = require("which-key")
		wk.register({
			["<Leader>gg"] = { "<cmd>LazyGit<CR>", "Display LazyGit" },
		})
	end,
}
