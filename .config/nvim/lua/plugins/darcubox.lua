return {
	{
		"Koalhack/darcubox-nvim",
		priority = 1000,
		config = function()
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
			local icon_colors = {
				red = "#fb4934", -- Gruvbox Bright Red
				orange = "#fe8019", -- Gruvbox Bright Orange (Iconic)
				yellow = "#fabd2f", -- Gruvbox Bright Yellow

				-- Cool tones (Darcula Material inspired)
				green = "#98c379", -- Material Green (cleaner than Gruvbox olive)
				cyan = "#56b6c2", -- Material Cyan
				blue = "#61afef", -- Material Blue (High visibility)
				purple = "#c678dd", -- Material Purple
				-- Neutrals
				grey = "#9399b2", -- Soft Grey
				azure = "#89dceb",
			}

			for name, color in pairs(icon_colors) do
				-- This creates highlights like "MiniIconsBlue", "MiniIconsRed", etc.
				vim.api.nvim_set_hl(
					0,
					"MiniIcons" .. name:gsub("^%l", string.upper),
					{ fg = color }
				)
			end
		end,
	},
}
