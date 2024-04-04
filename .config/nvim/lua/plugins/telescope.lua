-- file finder

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local builtin = require("telescope.builtin")

		-- use ctrl+p to find files in git
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})

		-- use leader+ff to find all files
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})

		-- use leader+fg to live grep the code base
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

		-- use leader+fb to search open buffers
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
	end,
}
