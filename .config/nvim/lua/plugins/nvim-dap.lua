-- debugging plugin

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{ "theHamsta/nvim-dap-virtual-text" },
		{ "rcarriga/nvim-dap-ui" },
		{ "suketa/nvim-dap-ruby" },
		{ "leoluz/nvim-dap-go" },
	},
	config = function()
		local dap = require("dap")

		vim.fn.sign_define("DapBreakpoint", { text = "⬢", texthl = "Yellow", linehl = "", numhl = "Yellow" })
		vim.fn.sign_define("DapStopped", { text = "▶", texthl = "Green", linehl = "ColorColumn", numhl = "Green" })

		require("dapui").setup({
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					size = 40,
					position = "left",
				},
				{
					elements = {},
					size = 10,
					position = "bottom",
				},
			},
		})

		require("dap-ruby").setup()
		require("dap-go").setup()
	end,
}
