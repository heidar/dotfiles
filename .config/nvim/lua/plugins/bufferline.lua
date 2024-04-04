-- bufferline to show open buffers

return {
	"akinsho/bufferline.nvim",
	event = "VimEnter",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "folke/which-key.nvim" },
	},
	config = function()
		local mocha = require("catppuccin.palettes").get_palette("mocha")
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				style_preset = {
					bufferline.style_preset.no_italic,
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

		-- setup keybinds
		local wk = require("which-key")
		wk.register({
			["<Tab>"] = { ":BufferLineCycleNext<CR>", "Next buffer" },
			["<S-Tab>"] = { ":BufferLineCyclePrev<CR>", "Previous buffer" },
			["<Leader>w"] = { ":bd<CR>", "Close current buffer" },
		})
	end,
}
