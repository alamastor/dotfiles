local M = {}

M.prequire = function (...)
	local status, module = pcall(require, ...)
	if status then
		return module
	else
		return nil
	end
end

return M
