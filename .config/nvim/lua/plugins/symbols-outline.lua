-- tree like view for symbols

return {
	"simrat39/symbols-outline.nvim",
	event = "BufEnter",
	config = function()
		require("symbols-outline").setup()

		local wk = require("which-key")
		wk.register({
			["<Leader>oo"] = { "<cmd>:SymbolsOutline<cr>", "Toggle symbol tree" },
		})
	end,
}
