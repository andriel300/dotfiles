return {
	"navarasu/onedark.nvim",
	lazy = true,
	opts = {
		style = "darker", -- dark, darker, cool, deep, warm, warmer, light
		transparent = true,
		toggle_style_key = nil, -- we use <leader>uC for that
		code_style = {
			comments = "italic",
			functions = "bold",
			keywords = "italic",
			strings = "none",
			variables = "none",
		},
		highlights = {
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },
		},
	},
}
