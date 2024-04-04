-- better experience using marks

return {
	"chentoast/marks.nvim",
	event = "BufEnter",
	config = function()
		require("marks").setup()
	end,
}
