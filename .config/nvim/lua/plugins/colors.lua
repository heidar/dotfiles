-- plugin for setting up color schemes

return {
	"catppuccin/nvim",
	-- to avoid it being called "nvim"
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
		integrations = {
			alpha = true,
			cmp = true,
			fidget = true,
			gitsigns = true,
			mason = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
			neotest = true,
			treesitter = true,
			telescope = {
				enabled = true,
			},
			which_key = true,
		},
	},
}
