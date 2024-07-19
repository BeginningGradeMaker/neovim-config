return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- dependencies = {
	-- 	"neovim/nvim-lspconfig"
	-- },
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			auto_install = true,
			highlight = {
				enable = true,
				disable = { "latex" },
				additional_vim_regex_highlighting = { "latex", "markdown" },
			},
			indent = { enable = true, disable = {"typst"}},
		})
	end,
}
