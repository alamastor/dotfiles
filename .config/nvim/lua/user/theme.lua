-- Gruvbox Theme
vim.o.background = "dark"
require("gruvbox").setup({
	contrast = "hard",
})

local schemes = {
	"gruvbox",
	"minischeme",
}
local current_scheme = -1

local function next_scheme()
	current_scheme = (current_scheme + 1) % #schemes
	vim.cmd("colorscheme " .. schemes[current_scheme + 1])
end

local function togglebg()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
end

next_scheme()

vim.api.nvim_create_user_command("Colorscheme", function(opts)
	if opts.args == "next" then
		next_scheme()
	elseif opts.args == "togglebg" then
		togglebg()
	end
end, {
	nargs = 1,
	complete = function()
		return { "next", "togglebg" }
	end,
})
