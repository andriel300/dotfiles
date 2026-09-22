return {
	-- 1. Disable the default icon plugin
	{
		"nvim-tree/nvim-web-devicons",
		enabled = false,
	},

	-- 2. Add mini.icons and ensure it loads correctly
	{
		"nvim-mini/mini.icons",
		opts = {},
		lazy = true,
		init = function()
			-- This is the crucial part:
			-- It tells other plugins (like telescope, nvim-tree, etc.)
			-- to use mini.icons instead of the missing web-devicons.
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
}
