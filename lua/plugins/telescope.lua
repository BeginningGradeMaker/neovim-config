return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		cmd = "Telescope",
		keys = {
			{
				"<leader><leader>",
				function()
					return require("telescope.builtin").find_files()
				end,
				desc = "Find files",
			},
			{
				"<leader>fw",
				function()
					return require("telescope.builtin").live_grep()
				end,
				desc = "Live grep",
			},
			{
				"<leader>fh",
				function()
					return require("telescope.builtin").help_tags({ cache_picker = false })
				end,
				desc = "Help",
			},
			{
				"<leader>fk",
				function()
					return require("telescope.builtin").keymaps({ cache_picker = false })
				end,
				desc = "Keymaps",
			},
			{
				"<leader>fb",
				function()
					return require("telescope.builtin").builtin({ cache_picker = false })
				end,
				desc = "Select",
			},
			{
				"<leader>fH",
				function()
					return require("telescope.builtin").highlights({ cache_picker = false })
				end,
				desc = "Highlight",
			},
			{
				"<leader>fC",
				function()
					return require("telescope.builtin").grep_string()
				end,
				desc = "Current word",
			},
			{
				"<leader>fd",
				function()
					return require("telescope.builtin").diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>l",
				function()
					return require("telescope.builtin").resume()
				end,
				desc = "Resume last search",
			},
			{
				"<leader>f.",
				function()
					return require("telescope.builtin").oldfiles({ cache_picker = false })
				end,
				desc = "Recent files",
			},
			-- { "<leader>b", "<cmd>Telescope buffers sort_mru=true sort_lastused=true previewer=false<cr>", desc = "Existing buffers", silent = true },
			{
				"<leader>b",
				function()
					require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end,
				desc = "Existing buffers",
				silent = true,
			},
			{ "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Options", silent = true },
			{
				"<leader>ff",
				function()
					return require("telescope.builtin").lsp_document_symbols({ symbols = { "function", "method" } })
				end,
				desc = "Methods",
			},
			{
				"<leader>fs",
				function()
					return require("telescope.builtin").lsp_document_symbols({
						symbols = { "struct", "class", "typeparameter", "enum" },
					})
				end,
				desc = "Structs",
			},

			{
				"<leader>fc",
				function()
					return require("telescope.builtin").lsp_document_symbols({ symbols = { "constant" } })
				end,
				desc = "Constants",
			},

			{
				"<leader>m",
				function()
					return require("telescope.builtin").marks(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = true,
						path_display = "hidden",
						initial_mode = "normal",
						cache_picker = false,
					}))
				end,
				desc = "Marks",
			},
			{
				"<leader>fR",
				function()
					return require("telescope.builtin").registers({ cache_picker = false })
				end,
				desc = "Registers",
			},
			{
				"<leader>fq",
				function()
					return require("telescope.builtin").quickfix()
				end,
			},

			-- Change colorschemes
			{
				"<leader>uT",
				function()
					return require("telescope.builtin").colorscheme(require("telescope.themes").get_dropdown({
						cache_picker = false,
						winblend = 10,
						previwer = false,
					}))
				end,
				desc = "Find colorschemes",
			},
			-- Slightly advanced example of overriding default behavior and theme
			{
				"<leader>/",
				function()
					-- You can pass additional configuration to telescope to change theme, layout, etc.
					require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = true,
					}))
				end,
				desc = "Fuzzily search",
			},

			-- Shortcut for searching your neovim configuration files
			{
				"<leader>fn",
				function()
					require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config"), cache_picker = false })
				end,
				desc = "NeoVim files",
			},
			-- Search for plugin source code
			{
				"<leader>fp",
				function()
					require("telescope.builtin").find_files({
						cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
						cache_picker = false,
					})
				end,
				desc = "Plugin files",
			},
			{
				"<leader>fp",
				function()
					require("config.telescope.mutligrep").live_multigrep({})
				end,
				desc = "Plugin files",
			},
			{ "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo history", silent = true },
		},
		config = function()
			local actions = require("telescope.actions")
			local get_icon = require("utils").get_icon
			require("telescope").setup({
				pickers = {
					colorscheme = { enable_preview = true },
					find_files = {
						find_command = { "rg", "--files", "--sortr=modified" },
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
				defaults = {
					git_worktrees = vim.g.git_worktrees,
					prompt_prefix = get_icon("Selected", 1, true),
					selection_caret = get_icon("Selected", 1, true),
					path_display = { "smart" },
					sorting_strategy = "ascending",
					layout_strategy = "bottom_pane",
					layout_config = {
						horizontal = { prompt_position = "top", preview_width = 0.55 },
						vertical = { mirror = false },
						width = 0.87,
						height = 0.60,
						preview_cutoff = 120,
					},
					mappings = {
						i = {
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,
							["<C-l>"] = actions.cycle_history_next,
							["<C-h>"] = actions.cycle_history_prev,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-t>"] = require("trouble.sources.telescope").open,
							["<RightMouse>"] = actions.close,
							["<LeftMouse>"] = actions.select_default,
							["<ScrollWheelDown>"] = actions.move_selection_next,
							["<ScrollWheelUp>"] = actions.move_selection_previous,
						},
						n = {
							q = actions.close,
							["<C-j>"] = actions.results_scrolling_up,
							["<C-k>"] = actions.results_scrolling_down,
							["<C-t>"] = require("trouble.sources.telescope").open,
							["<RightMouse>"] = actions.close,
							["<LeftMouse>"] = actions.select_default,
							-- ["<ScrollWheelDown>"] = actions.move_selection_next,
							-- ["<ScrollWheelUp>"] = actions.move_selection_previous,
						},
					},
					file_ignore_patterns = { "compile_commands.json", "lazy-lock.json" },
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension, "undo")
		end,
	},
	{ -- TODO: replace telescope with fzf-lua
		"ibhagwan/fzf-lua",
        optional = true,
        enabled = false,
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({})
		end,
	},
}
