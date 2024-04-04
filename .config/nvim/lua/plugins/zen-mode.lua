-- plugin for distraction free coding

return {
	"folke/zen-mode.nvim",
	opts = {},
	config = function()
		local wk = require("which-key")
		local zenmode = require("zen-mode")

		wk.register({
			["z"] = {
				function()
					zenmode.toggle()
				end,
				"Toggle zen mode",
			},
		}, { prefix = "<Leader>" })
	end,
}
