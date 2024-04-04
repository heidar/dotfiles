-- plugin for setting up color schemes

return {
	"catppuccin/nvim",
	-- to avoid it being called nvim
	name = "catppuccin",
	-- color scheme is needed on startup
	lazy = false,
	-- high priority to load color scheme first
	priority = 1000,
	opts = {
		-- latte, frappe, macchiato, mocha
		flavour = "mocha",
		-- disables setting the background color
		transparent_background = true,
		-- integrations for other plugins
		integrations = {},
	},
}
