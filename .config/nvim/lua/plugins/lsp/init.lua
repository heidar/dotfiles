-- lsp and related functionality

return {
	{
		"neovim/nvim-lspconfig",
		-- after reading the file into buffer
		event = "BufReadPost",
		dependencies = {
			-- lsp server manager
			{ "williamboman/mason.nvim", opts = {}, run = ":MasonUpdate" },

			-- lsp configuration for mason lsp
			"williamboman/mason-lspconfig.nvim",

			-- status for lsp
			{ "j-hui/fidget.nvim", opts = {}, tag = "legacy", event = "LspAttach" },

			-- various lsp improvements
			{ "glepnir/lspsaga.nvim", opts = {} },
		},
		opts = {
			-- install these lsps
			servers = {
				"gopls",
				"lua_ls",
				"solargraph",
			},
		},

		-- load lsp servers
		config = function(_, opts)
			-- on attach
			local on_attach = function(client, bufnr)
				----------------------------------
				-- Load key mappings
				----------------------------------
				require("smaili.plugins.lsp.key-mappings")(bufnr)
			end
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			-- make sure the lsps are installed
			require("mason-lspconfig").setup({ ensure_installed = opts.servers })
			-- load the lsps
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local server_opts = {}
					server_opts["capabilities"] = capabilities
					server_opts["on_attach"] = on_attach
					require("lspconfig")[server_name].setup(server_opts)
				end,
			})
		end,
	},

	-- auto complete
	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			vim.opt.runtimepath:append("~/github/lsp_signature.nvim")

			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
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
			}
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{
				"L3MON4D3/LuaSnip",
				opts = {},
				build = "make install_jsregexp",
			},
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"ray-x/lsp_signature.nvim",
		},
	},
}
