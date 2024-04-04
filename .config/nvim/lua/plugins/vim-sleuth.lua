-- automatic tabstop and shiftwidth detection

return {
	"tpope/vim-sleuth",
	event = { "BufReadPost", "BufNewFile" },
}
