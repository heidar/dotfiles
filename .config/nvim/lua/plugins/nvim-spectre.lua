return {
	"nvim-pack/nvim-spectre",
	event = "BufEnter",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
	},
	config = function()
		local wk = require("which-key")
		local spectre = require("spectre")
		wk.register({
			["<Leader>S"] = {
				function()
					spectre.toggle()
				end,
				"Toggle Spectre",
			},
			["<Leader>sw"] = {
				function()
					spectre.open_visual({ select_word = true })
				end,
				"Search current world",
			},
		})
	end,
}
