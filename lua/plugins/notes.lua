-- lazy.nvim
return {
	{
		"lervag/vimtex",
		ft = "tex",
		config = function()
			-- Vim-tex
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_quickfix_mode = 0
			vim.g.vimtex_compiler_progname = "nvr"
			vim.g.vimtex_view_general_viewer = "skim"
			vim.g.vimtex_view_method = "skim"
			-- vim.g.vimtex_indent_delims = {
			--    open = '{',
			--    close = '}',
			--    close_indented = 0,
			--    include_modified_math = 1,
			-- }
			vim.g.vimtex_view_skim_sync = 1
			-- vim.g.vimtex_quickfix_ignore_filters = { "Underfull", "Overfull", "Missing" }
			-- vim.g.maplocalleader = ','
			vim.g.vimtex_quickfix_open_on_warning = 0
			vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
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
	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	lazy = true,
	-- 	ft = "codecompanion", -- If you decide to lazy-load anyway
	--
	-- 	dependencies = {
	-- 		-- You will not need this if you installed the
	-- 		-- parsers manually
	-- 		-- Or if the parsers are in your $RUNTIMEPATH
	-- 		"nvim-treesitter/nvim-treesitter",
	--
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- },
}