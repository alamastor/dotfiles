local M = {}
local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

local mason = require("mason")
M.mason = mason
mason.setup(settings)

function M.install_package(package_name)
	local registry = require("mason-registry")
	if registry.is_installed(package_name) == false then
		registry.get_package(package_name):install()
		print("Installed Mason package: " .. package_name)
	end
end

return M
