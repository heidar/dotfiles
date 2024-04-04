-- file finder

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "folke/which-key.nvim" },
		{ "nvim-telescope/telescope-frecency.nvim" },
		{ "kkharji/sqlite.lua" },
		"olimorris/persisted.nvim",
	},

	config = function()
		local actions = require("telescope.actions")
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				mappings = {
					i = {
						["<CR>"] = actions.select_default,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,
						["<C-b>"] = actions.preview_scrolling_up,
						["<C-f>"] = actions.preview_scrolling_down,
					},
				},
				file_ignore_patterns = { "node_modules", "vendor" },
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("frecency")
		telescope.load_extension("persisted")

		-- setup keybinds
		local builtin = require("telescope.builtin")
		local wk = require("which-key")
		wk.register({
			["<Leader>fp"] = { builtin.git_files, "Find project files" },
			["<Leader>ff"] = { builtin.find_files, "Find files" },
			["<Leader>fb"] = { builtin.buffers, "Search open buffers" },
			["<Leader>fo"] = { builtin.oldfiles, "Search recent files" },
			["<Leader>fg"] = { builtin.live_grep, "Live grep" },
			["<Leader>fs"] = { "<cmd>Telescope persisted<cr>", "Search sessions" },
		})
	end,
}
