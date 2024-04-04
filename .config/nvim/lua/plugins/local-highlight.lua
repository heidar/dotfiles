-- highlight same word in buffer

return {
	"tzachar/local-highlight.nvim",
	event = "BufEnter",
	config = function()
		require("local-highlight").setup()
	end,
}
