-- bufferline to show open buffers

return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local mocha = require("catppuccin.palettes").get_palette("mocha")
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				style_preset = {
					bufferline.style_preset.no_italic,
				},
				indicator = {
					style = "none",
				},
				modified_icon = "●",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
			highlights = require("catppuccin.groups.integrations.bufferline").get({
				styles = { "italic", "bold" },
				custom = {
					mocha = {
						background = { fg = mocha.text },
					},
				},
			}),
		})
	end,
}
