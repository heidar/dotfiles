-- formatter is for formatting code

return {
	"mhartington/formatter.nvim",
	event = "BufEnter",
	config = function()
		require("formatter").setup({
			-- languages to have formatting for
			filetype = {
				go = {
					-- gofmt for go
					require("formatter.filetypes.go").gofmt,
					-- goimports for go
					require("formatter.filetypes.go").goimports,
				},
				lua = {
					-- stylua for lua
					require("formatter.filetypes.lua").stylua,
				},
				rust = {
					-- rustfmt for rust
					require("formatter.filetypes.rust").rustfmt,
				},
				ruby = {
					-- rubocop for ruby
					require("formatter.filetypes.ruby").rubocop,
				},
			},
		})

		-- bind leader + shift + f to format the current file
		vim.keymap.set("n", "<leader>F", ":FormatWrite<cr>", {})
	end,
}
