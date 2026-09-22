-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Persist colorscheme choice across Neovim sessions
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		require("util.colorscheme").save()
	end,
})
