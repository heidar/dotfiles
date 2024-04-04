-- lsp and related functionality

return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		-- lsp support
		{ "neovim/nvim-lspconfig" }, -- required
		{ "williamboman/mason.nvim" }, -- optional
		{ "williamboman/mason-lspconfig.nvim" }, -- optional

		-- autocompletion
		{ "hrsh7th/nvim-cmp" }, -- required
		{ "hrsh7th/cmp-nvim-lsp" }, -- required
		{ "L3MON4D3/LuaSnip" }, -- required
	},

	config = function()
		local lsp = require("lsp-zero").preset({})

		lsp.on_attach(function(_, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			lsp.default_keymaps({ buffer = bufnr })
		end)

		-- configure lua language server for neovim
		require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
		require("lspconfig").gopls.setup({})
		require("lspconfig").solargraph.setup({})
		require("lspconfig").golangci_lint_ls.setup({})

		lsp.setup()

        -- setup keybinds
		local wk = require("which-key")
		wk.register({
			["<Leader>ma"] = { "<cmd>Mason<CR>", "Mason" },
		})
	end,
}
