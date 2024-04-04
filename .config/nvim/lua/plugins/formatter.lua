return {
	"mhartington/formatter.nvim",
	config = function()
		require("formatter").setup({
			filetype = {
				go = {
					require("formatter.filetypes.go").stylua,
				},
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				ruby = {
					require("formatter.filetypes.ruby").stylua,
				},
			},
		})
		vim.keymap.set("n", "<leader>F", ":FormatWrite<cr>", {})
	end,
}
