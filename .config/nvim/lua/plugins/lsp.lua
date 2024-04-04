-- lsp and related functionality

return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	event = "BufRead",
	dependencies = {
		-- lsp support
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{
			"nvimdev/lspsaga.nvim",
			config = function()
				require("lspsaga").setup({})
			end,
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
				"nvim-tree/nvim-web-devicons",
			},
		},

		-- autocompletion
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "onsails/lspkind.nvim" },

		-- snippets
		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },

		{ "folke/which-key.nvim" },
	},

	config = function()
		local lsp = require("lsp-zero")
		local lspconfig = require("lspconfig")

		lsp.preset("recommended")
		lsp.extend_cmp()

		-- ensure these language servers are installed
		require("mason-lspconfig").setup({
			ensure_installed = {
				"gopls",
				"lua_ls",
				"solargraph",
			},
		})

		-- nvim-cmp setup
		local cmp = require("cmp")
		local wk = require("which-key")

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = {
					border = "rounded",
				},
				documentation = {
					border = "rounded",
				},
				hover = {
					border = "rounded",
				},
			},
			formatting = {
				format = require("lspkind").cmp_format({}),
			},

			-- keybinds for nvim-cmp
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- sources for nvim-cmp
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "nvim_lua" },
			}),
		})

		-- setup cmp to work with autopairs
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		-- configure lsp mappings
		lsp.on_attach(function(_, bufnr)
			wk.register({
				["gd"] = {
					function()
						vim.lsp.buf.definition()
					end,
					"Go to definition",
				},
				["K"] = {
					function()
						vim.lsp.buf.hover()
					end,
					"Show information",
				},
				["<Leader>ca"] = {
					function()
						vim.lsp.buf.code_action()
					end,
					"Code action",
				},
				["<Leader>rr"] = {
					function()
						vim.lsp.buf.references()
					end,
					"References",
				},
				["<Leader>rn"] = {
					function()
						vim.lsp.buf.rename()
					end,
					"Rename",
				},
			}, { buffer = bufnr })
		end)

		-- configure language servers
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
		lspconfig.gopls.setup({ capabilities = capabilities })
		lspconfig.solargraph.setup({ capabilities = capabilities })
		lspconfig.golangci_lint_ls.setup({ capabilities = capabilities })

		-- mason keybind
		wk.register({
			["<Leader>ma"] = { "<cmd>Mason<CR>", "Mason" },
		})
	end,
}
