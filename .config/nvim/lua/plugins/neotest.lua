-- plugin for running tests

return {
	"nvim-neotest/neotest",
	event = "BufEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-plenary",
		"nvim-neotest/neotest-go",
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-plenary"),
				require("neotest-go"),
			},
		})

		-- keybindings
		local wk = require("which-key")
		wk.register({
			["<Leader>tr"] = {
				function()
					neotest.run.run()
				end,
				"Run nearest test",
			},
			["<Leader>tf"] = {
				function()
					neotest.run.run(vim.fn.expand("%"))
				end,
				"Run test file",
			},
			["<Leader>ts"] = {
				function()
					neotest.run.stop()
				end,
				"Stop nearest test",
			},
		})
	end,
}
