local M = {}
-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Remap space as leader key
-- Needs to be done before using leader in any maps!
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

M.reload = function()
	R("user.keymaps")
	print("Keymaps reloaded.")
end
keymap("n", "<leader>rr", "<cmd>lua require('user.keymaps').reload()<cr>")

-- Format file --
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", {})

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
keymap("n", "<leader>dn", "<cmd>lua require('dap-python').test_method()<cr>", opts)
keymap("v", "<leader>ds", "<cmd>lua require('dap-python').debug_selection()<cr>", opts)

return M
