return {
	{
		"Koalhack/darcubox-nvim",
		config = function()
			-- Setup darcubox with custom options
			require("darcubox").setup({
				options = {
					transparent = true,
					styles = {
						comments = { italic = true },
						functions = { bold = true },
						keywords = { italic = true },
						types = { italic = true, bold = true },
					},
				},
			})
		end,
		-- optional: ensure darcubox loads after plugins like lualine, telescope etc
		-- priority = 1000, -- sometimes used to control load order
	},
}
