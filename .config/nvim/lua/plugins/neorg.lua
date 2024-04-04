return {
	"nvim-neorg/neorg",
	run = ":Neorg sync-parsers",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/documents/notes",
						},
					},
				},
				["core.concealer"] = {},
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
			},
		})
	end,
}
