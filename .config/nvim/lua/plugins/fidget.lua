-- show lsp status

return {
	"j-hui/fidget.nvim",
	event = "BufEnter",
	opts = {
		window = {
			blend = 0,
			relative = "editor",
		},
	},
	tag = "legacy",
}
