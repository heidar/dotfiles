-- show lsp diagnostics in the sign column

return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	event = "BufEnter",
	config = function()
		-- diagnostic signs
		local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		require("lsp_lines").setup(vim.diagnostic.config({
			-- disable virtual_text since it's redundant due to lsp_lines.
			virtual_text = false,
			signs = {
				active = signs,
			},
		}))
	end,
}
