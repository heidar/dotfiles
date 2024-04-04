-- highlight same word in buffer

return {
	"tzachar/local-highlight.nvim",
	event = "VeryLazy",
	config = function()
		require("local-highlight").setup()
	end,
}
