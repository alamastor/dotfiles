return {
	test_method = function()
		vim.cmd("lua require('dap-python').test_method()")
	end,

	format_file = function()
		vim.cmd( [[silent exec "%!black -q -"]] )
	end,

	organize_imports = function()
		vim.cmd( [[silent exec "%!isort -q --profile black -"]] )
	end
}
