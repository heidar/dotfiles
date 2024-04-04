-- automated session management

return {
	"olimorris/persisted.nvim",
	config = function()
		require("persisted").setup()
		local wk = require("which-key")
		wk.register({
			["<Leader>st"] = { "<cmd>:SessionToggle<cr>", "Toggle session loading" },
			["<Leader>ss"] = { "<cmd>:SessionSave<cr>", "Save session" },
			["<Leader>sl"] = { "<cmd>:SessionLoad<cr>", "Load session" },
			["<Leader>so"] = { "<cmd>:SessionLoadLast<cr>", "Load last session" },
			["<Leader>sd"] = { "<cmd>:SessionDelete<cr>", "Delete session" },
		})

		-- workaround for error message when quitting neovim
		-- https://github.com/olimorris/persisted.nvim/issues/84
		vim.api.nvim_create_autocmd({ "VimLeave" }, {
			callback = function()
				vim.cmd("!notify-send ''")
				vim.cmd("sleep 10m")
			end,
		})
	end,
}
