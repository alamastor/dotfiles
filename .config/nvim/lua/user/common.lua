local M = {}
local registry = require("mason-registry")

M.prequire = function(...)
  local status, module = pcall(require, ...)
  if status then
    return module
  else
    return nil
  end
end

---Install Mason packages, if not already.
---@param package_names string|string[]
function M.ensure_mason_installed(package_names)
  if type(package_names) == "string" then
    package_names = { package_names }
  end
  for _, package_name in ipairs(package_names) do
    if registry.is_installed(package_name) == false then
      registry.get_package(package_name):install()
      print("Installed Mason package: " .. package_name)
    end
  end
end

return M
