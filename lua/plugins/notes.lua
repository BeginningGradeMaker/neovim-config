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
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		--   "BufReadPre path/to/my-vault/**.md",
		--   "BufNewFile path/to/my-vault/**.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/Documents/Crypto/URA_S24",
				},
				-- {
				-- 	name = "work",
				-- 	path = "~/vaults/work",
				-- },
			},

			-- see below for full list of options 👇
		},
	},
}
