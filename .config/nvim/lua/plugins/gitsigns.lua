-- show git signs in the sign column

return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	config = function()
		local gs = require("gitsigns")
		local wk = require("which-key")

        -- setup gitsigns with defaults
		gs.setup({})

        -- keybinds for gitsigns
		wk.register({
			d = { gs.diffthis, "Diff this" },
			u = { gs.undo_stage_hunk, "Undo stage hunk" },
			S = { gs.stage_buffer, "Stage buffer" },
			b = { gs.blame_line, "Blame line" },
			p = { gs.preview_hunk_inline, "Preview hunk" },
		}, { prefix = "<leader>g" })
		wk.register({
			U = { ":Gitsigns reset_hunk<CR>", "Reset hunk" },
			s = { ":Gitsigns stage_hunk<CR>", "Stage hunk" },
		}, { mode = { "n", "v" }, prefix = "<leader>g" })
	end,
}
