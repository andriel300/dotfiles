return {
	"rose-pine/neovim",
	lazy = true,
	name = "rose-pine",
	opts = {
		variant = "auto", -- auto, main, moon, dawn
		dark_variant = "moon",
		styles = {
			transparency = true,
		},
		highlight_groups = {
			-- Make floats transparent
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },
		},
	},
}
