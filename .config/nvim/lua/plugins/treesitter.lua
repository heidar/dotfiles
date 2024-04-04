-- nvim-treesitter provides better code highlighting and navigation

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			-- list of parses that are desired
			ensure_installed = { "go", "git_rebase", "gitcommit", "json", "lua", "ruby", "sql", "yaml" },
			-- install parsers synchronously
			sync_install = false,

			highlight = {
				-- enable highlighting, setting to false will disable it
				enable = true,
				-- turning this on can cause performance problems and duplicate highlights but this can be enabled for specific languages if needed
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		})
	end,
}
