-- draw borders around various dialogues and windows

return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		-- set border for lsp floating windows
		local border = "rounded"
		local handlers = vim.lsp.handlers
		handlers["textDocument/hover"] = vim.lsp.with(handlers.hover, {
			border = border,
		})
	end,
}
