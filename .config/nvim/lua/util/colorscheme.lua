--- Persist the current colorscheme across Neovim sessions.
--- Saves to a small state file on ColorScheme change, reads on startup.

local M = {}

local state_file = vim.fn.stdpath("config") .. "/colorscheme_state"

function M.save()
	local name = vim.g.colors_name
	if name and name ~= "" then
		local f = io.open(state_file, "w")
		if f then
			f:write(name)
			f:close()
		end
	end
end

function M.load(default)
	default = default or "darcubox"
	local f = io.open(state_file, "r")
	if f then
		local name = f:read("*l")
		f:close()
		if name and name ~= "" then
			return name
		end
	end
	return default
end

return M
