return {
	"nvimdev/guard.nvim",
	dependencies = {
		"nvimdev/guard-collection",
	},
	config = function()
		local ft = require("guard.filetype")

		ft("python"):fmt("black")

		require("guard").setup({
			fmt_on_save = true,
			lsp_as_default_formatter = true,
		})
	end,
}
