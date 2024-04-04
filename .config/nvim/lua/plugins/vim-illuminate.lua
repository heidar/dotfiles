return {
	"RRethy/vim-illuminate",
	event = "BufEnter",
	config = function()
		require("illuminate").configure({})
	end,
}
