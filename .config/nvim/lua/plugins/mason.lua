return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
				"tailwindcss-language-server",
				"typescript-language-server",
				"prettierd",
			},
		},
	},
}
