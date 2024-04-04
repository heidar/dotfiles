local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local b = null_ls.builtins

local sources = {
	-- lua
	b.formatting.stylua,

	-- ruby
	b.formatting.rubocop,
	b.diagnostics.rubocop,
	b.formatting.erb_lint,
	b.diagnostics.erb_lint,

	-- go
	b.formatting.gofumpt,
	b.diagnostics.golangci_lint,
}

null_ls.setup({
	debug = true,
	sources = sources,
})
