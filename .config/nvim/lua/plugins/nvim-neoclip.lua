-- clipboard manager

return {
	"AckslD/nvim-neoclip.lua",
	event = "BufEnter",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
		{ "kkharji/sqlite.lua" },
	},
	config = function()
		require("neoclip").setup({
			-- save history to sqlite database
			enable_persistent_history = true,
			keys = {
				telescope = {
					i = {
						-- override default <C-k> map
						paste_behind = "<C-pb>",
					},
				},
			},
		})
	end,
}
