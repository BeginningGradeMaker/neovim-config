return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    event = "VeryLazy",
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
			indent = { enable = true, disable = {"rust"}},
		})
	end,
}
