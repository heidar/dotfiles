-- profiling for neovim's startup time

return {
	"dstein64/vim-startuptime",
	-- lazy-load on a command
	cmd = "StartupTime",
	-- init is called during startup - configuration for vim plugins typically should be set in an init function
	init = function()
		-- how many startup tries are averaged
		vim.g.startuptime_tries = 10
	end,
}
