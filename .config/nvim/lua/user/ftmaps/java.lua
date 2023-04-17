return {
	organize_imports = function()
		vim.cmd("lua require('jdtls').organize_imports()")
	end,
	extract_variable = function()
		vim.cmd("lua require('jdtls').extract_variable()")
	end,
	extract_constant = function()
		vim.cmd("lua 	require('jdtls').extract_constant()")
	end,
	extract_method = function()
		vim.cmd("lua 	require('jdtls').extract_method(true)")
	end,
	test_class = function()
		vim.cmd("lua 	require('jdtls').test_class()")
	end,
	test_method = function()
		vim.cmd("lua 	require('jdtls').test_nearest_method()")
	end,
}
