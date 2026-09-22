return {
	"rebelot/kanagawa.nvim",
	lazy = true,
	opts = {
		transparent = true,
		overrides = function(colors)
			local theme = colors.theme
			return {
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },
			}
		end,
		theme = "wave", -- wave, dragon, lotus
		background = {
			dark = "wave",
			light = "lotus",
		},
	},
}
