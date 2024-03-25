-- lazy.nvim
return {
	{
		"lervag/vimtex",
		ft = "tex",
		config = function()
			vim.g.vimtex_view_method = "skim"
			-- vim.g.vimtex_quickfix_ignore_filters = { "Underfull", "Overfull", "Missing" }
			-- vim.g.maplocalleader = ','
			vim.g.vimtex_quickfix_open_on_warning = 0
		end,
	},
	-- install with yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}
