-- manage undo history

return {
	"mbbill/undotree",
	config = function()
		local wk = require("which-key")
		wk.register({
			["<Leader>u"] = {
				function()
					vim.cmd.UndotreeToggle()
				end,
				"Show undo tree",
			},
		})
	end,
}
