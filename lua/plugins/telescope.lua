return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		tag = "0.1.6",
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
			{
				"andrew-george/telescope-themes",
			},
			-- { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
			-- {
			-- 	"tristone13th/lspmark.nvim",
			-- },
		},
		config = function()
			local actions = require("telescope.actions")
			local get_icon = require("utils").get_icon
			require("telescope").setup({
				pickers = {
					colorscheme = { enable_preview = true },
					-- find_files = {
					--     find_command = {"rg", "--files", "--sortr=modified"}
					-- }
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
					["themes"] = {
						enable_live_preview = true,
						enable_previewer = true,
						persist = { enabled = true, path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua" },
					},
				},
				defaults = {
					git_worktrees = vim.g.git_worktrees,
					prompt_prefix = get_icon("Selected", 1, true),
					selection_caret = get_icon("Selected", 1, true),
					path_display = { "smart" },
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = { prompt_position = "bottom", preview_width = 0.55 },
						vertical = { mirror = false },
						width = 0.87,
						height = 0.80,
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
							["<RightMouse>"] = actions.close,
							["<LeftMouse>"] = actions.select_default,
							["<ScrollWheelDown>"] = actions.move_selection_next,
							["<ScrollWheelUp>"] = actions.move_selection_previous,
						},
						n = {
							q = actions.close,
							["<C-j>"] = actions.results_scrolling_up,
							["<C-k>"] = actions.results_scrolling_down,
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
			pcall(require("telescope").load_extension, "themes")
			-- pcall(require("telescope").load_extension, "lspmark")

			local builtin = require("telescope.builtin")
			-- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Files" })
			vim.keymap.set("n", "?", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
			vim.keymap.set("n", "<leader>fH", builtin.builtin, { desc = "Select telescope" })
			vim.keymap.set("n", "<leader>fW", builtin.grep_string, { desc = "Current word" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
			vim.keymap.set("n", "<leader>fl", builtin.resume, { desc = "Resume last search" })
			vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "Recent files" })
			vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Existing buffers" })
			vim.keymap.set("n", "<leader>ff", function()
				return builtin.lsp_document_symbols({ symbols = { "function", "method" } })
			end, { desc = "Methods" })
			vim.keymap.set("n", "<leader>fs", function()
				return builtin.lsp_document_symbols({ symbols = { "struct", "class", "typeparameter", "enum" } })
			end, { desc = "Structs" })

			vim.keymap.set("n", "<leader>fc", function()
				return builtin.lsp_document_symbols({ symbols = { "constant" } })
			end, { desc = "Constants" })

			vim.keymap.set("n", "<leader>fm", function()
				return builtin.marks({ defaults = {path_display = { "hidden" }} })
			end, { desc = "Marks" })
			vim.keymap.set("n", "<leader>fp", function()
				return builtin.registers()
			end, { desc = "Registers" })

			-- Change colorschemes
			vim.keymap.set("n", "<leader>ft", builtin.colorscheme, { desc = "Change colorscheme" })
			-- vim.keymap.set("n", "<leader>ft", require("telescope").extensions.themes.themes, { desc = "Change colorscheme" })
			vim.keymap.set(
				"n",
				"<leader>fT",
				function()
					vim.cmd("Telescope themes")
				end,
				-- ":Telescope themes<CR>",
				{ noremap = true, silent = true, desc = "Change persistent colorscheme" }
			)

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = true,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- Shortcut for searching your neovim configuration files
			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "NeoVim files" })

			-- Lsp marks
			-- vim.keymap.set("n", "m", function()
			-- 	require("lspmark.bookmarks").toggle_bookmark({ with_comment = false })
			-- end, { desc = "Toogle bookmark" })
			-- vim.keymap.set("n", "<leader>m", function()
			-- 	vim.cmd("Telescope lspmark")
			-- end, { desc = "Show Lsp marks" })
			-- -- <new_dir> can be nil, by default it is cwd.
			-- require("lspmark.bookmarks").load_bookmarks()
			-- vim.api.nvim_create_autocmd({ "DirChanged" }, {
			-- 	callback = require("lspmark.bookmarks").load_bookmarks,
			-- 	pattern = { "*" },
			-- })
		end,
	},
}
