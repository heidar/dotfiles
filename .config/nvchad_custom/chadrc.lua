---@type ChadrcConfig
local M = {}

-- path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme = "ayu_dark",
	theme_toggle = { "ayu_dark", "ayu_light" },

	hl_override = highlights.override,
	hl_add = highlights.add,

	statusline = {
		separator_style = "arrow",
	},

	-- nvdash (dashboard)
	nvdash = {
		load_on_startup = true,
	},
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
