-- lsp and related functionality

return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
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
		{ "hrsh7th/cmp-cmdline" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "onsails/lspkind.nvim" },

		-- snippets
		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },
	},

	config = function()
		local lsp = require("lsp-zero")
		local lspconfig = require("lspconfig")

		lsp.preset("recommended")
		lsp.extend_cmp()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"gopls",
				"lua_ls",
				"solargraph",
			},
		})

		-- nvim-cmp setup
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {},
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

				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("luasnip").expand_or_jumpable() then
						require("luasnip").expand_or_jump()
					elseif cmp.has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			-- sources for nvim-cmp
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "cmdline" },
				{ name = "nvim_lua" },
			}),
		})

		-- configure lsp mappings
		lsp.on_attach(function(_, bufnr)
			local opts = { buffer = bufnr }

			local wk = require("which-key")
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
			}, opts)
		end)

		-- configure language servers
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
		lspconfig.gopls.setup({ capabilities = capabilities })
		lspconfig.solargraph.setup({ capabilities = capabilities })
		lspconfig.golangci_lint_ls.setup({ capabilities = capabilities })

		-- setup keybinds
		local wk = require("which-key")
		wk.register({
			["<Leader>ma"] = { "<cmd>Mason<CR>", "Mason" },
		})
	end,
}
