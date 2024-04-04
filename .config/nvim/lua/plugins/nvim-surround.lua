-- add/change/delete surrounding delimiter pairs with ease

return {
	"kylechui/nvim-surround",
	event = "InsertEnter",
	config = function()
		require("nvim-surround").setup({})
	end,
}
