local M = {}
local keymap = vim.keymap.set
local opts = { silent = true }
local prequire = require("user.common").prequire

local function remap(binding_fn_name)
	return string.format("<cmd>lua R('user.keymaps').bind('%s')<cr>", binding_fn_name)
end

M.bind = function(binding_fn_name)
	local filetype = vim.bo.filetype
	local module = prequire(string.format("user.ftmaps.%s", filetype))

	if module and module[binding_fn_name] then
		module[binding_fn_name]()
		return
	end

	local f = require("user.ftmaps.default")[binding_fn_name]
	if f then
		f()
	end
end

-- Remap space as leader key
-- Needs to be done before using leader in any maps!
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Reload this file
M.reload = function()
	R("user.keymaps")
	print("Keymaps reloaded.")
end
keymap("n", "<leader>rr", "<cmd>lua require('user.keymaps').reload()<cr>")

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
keymap("n", "<leader>dn", remap("test_method"), opts)
keymap("v", "<leader>ds", "<cmd>lua require('dap-python').debug_selection()<cr>", opts)


keymap("n", "<leader>lf", remap("format_file"), { noremap = true, silent = true })
keymap("n", "gD", remap("go_to_declaration"), { noremap = true, silent = true })
keymap("n", "gd", remap("go_to_definition"), { noremap = true, silent = true })
keymap("n", "K", remap("documentation"), { noremap = true, silent = true })
keymap("n", "gi", remap("implementation"), { noremap = true, silent = true })
keymap("n", "gr", remap("references"), { noremap = true, silent = true })
keymap("n", "gl", remap("diagnostic"), { noremap = true, silent = true })
keymap("n", "<leader>la", remap("code_action"), { noremap = true, silent = true })
keymap("n", "<leader>lj", remap("next_diagnostic"), { noremap = true, silent = true })
keymap("n", "<leader>lk", remap("next_diagnostic"), { noremap = true, silent = true })
keymap("n", "<leader>lr", remap("rename"), { noremap = true, silent = true })
keymap("n", "<leader>ls", remap("signature_help"), { noremap = true, silent = true })
keymap("n", "<leader>lo", remap("organize_imports"), { noremap = true, silent = true })
keymap("n", "<leader>lev", remap("extract_variable"), { noremap = true, silent = true })
keymap("n", "<leader>lec", remap("extract_constant"), { noremap = true, silent = true })
keymap("n", "<leader>lem", remap("extract_method"), { noremap = true, silent = true })

keymap("n", "<leader>li", "<cmd>LspInfo<cr>", { noremap = true, silent = true })
keymap("n", "<leader>lI", "<cmd>Mason<cr>", { noremap = true, silent = true })

keymap("n", "<leader>cn", "<cmd>Colorscheme next<cr>", { noremap = true, silent = true })

return M
