return {
	"rcarriga/nvim-notify",
	event = "VimEnter",
	config = function()
		vim.opt.termguicolors = true
		local notify = require("notify")
		vim.notify = notify
		notify.setup({
			background_colour = "#000000",
			render = "wrapped-compact",
		})
	end,
}
