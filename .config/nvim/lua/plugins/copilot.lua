-- plugin for copilot in neovim

return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = false,
			},
			suggestion = {
				enable = true,
				auto_trigger = true,
				keymap = {
					accept = "<C-f>",
					next = "<C-j>",
					prev = "<C-k>",
					dismiss = "<C-e>",
				},
			},
		})
	end,
}
