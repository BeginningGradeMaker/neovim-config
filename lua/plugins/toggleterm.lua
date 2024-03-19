return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			local get_height = function()
				return math.floor(vim.o.lines * 0.70)
			end
			local get_width = function()
				return math.floor(vim.o.columns * 0.80 - 1)
			end
			require("toggleterm").setup({
				-- size can be a number or function which is passed the current terminal
				size = get_height,
				open_mapping = [[<c-\><c-\>]],
				hide_numbers = true, -- hide the number column in toggleterm buffers
				shade_terminals = true,
				-- shading_factor = 1,       -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
				start_in_insert = true,
				insert_mappings = true, -- whether or not the open mapping applies in insert mode
				autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
				terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
				-- persist_size = true,
				direction = "float",
				close_on_exit = true, -- close the terminal window when the process exits
				shell = vim.o.shell, -- change the default shell
				float_opts = {
					width = get_width,
					height = get_height,
					border = "rounded",
				},
				highlights = {
					-- highlights which map to a highlight group name and a table of it's values
					-- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
					-- Normal = {
					--   link = 'Pmenu'
					-- },
					-- NormalFloat = {
					--   link = 'Pmenu'
					-- },
					-- FloatBorder = {
					--   link = 'Pmenu'
					-- },
				},
				winbar = {
					enabled = true,
					name_formatter = function(term) --  term: Terminal
						local buf_name = vim.api.nvim_buf_get_name(term.bufnr)
						if not buf_name then
							return term.name
						end
						local buf_len = string.len(buf_name)
						local colon_index = buf_name:match("^.*():")
						local slash_index = buf_name:match("^.*()/")
						local sub_index
						if colon_index then
							sub_index = colon_index
						elseif slash_index then
							sub_index = slash_index
						end
						if sub_index then
							buf_name = buf_name:sub(sub_index + 1, buf_len)
						end
						term.name = buf_name
						return buf_name
					end,
				},
			})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		config = function()
			-- nvim v0.8.0
			require("lazy").setup({
				{
					"kdheepak/lazygit.nvim",
					cmd = {
						"LazyGit",
						"LazyGitConfig",
						"LazyGitCurrentFile",
						"LazyGitFilter",
						"LazyGitFilterCurrentFile",
					},
					-- optional for floating window border decoration
					dependencies = {
						"nvim-lua/plenary.nvim",
					},
				},
			})
			vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
		end,
	},
	{
		"stevearc/resession.nvim",
		lazy = true,
		config = function()
			local resession = require("resession")
			resession.setup({
				-- Options for automatically saving sessions on a timer
				autosave = {
					enabled = false,
					-- How often to save (in seconds)
					interval = 60,
					-- Notify when autosaved
					notify = true,
				},
				-- Save and restore these options
				options = {
					"binary",
					"bufhidden",
					"buflisted",
					"cmdheight",
					"diff",
					"filetype",
					"modifiable",
					"previewwindow",
					"readonly",
					"scrollbind",
					"winfixheight",
					"winfixwidth",
				},
				-- Custom logic for determining if the buffer should be included
				buf_filter = require("resession").default_buf_filter,
				-- Custom logic for determining if a buffer should be included in a tab-scoped session
				tab_buf_filter = function(tabpage, bufnr)
					return true
				end,
				-- The name of the directory to store sessions in
				dir = "session",
				-- Show more detail about the sessions when selecting one to load.
				-- Disable if it causes lag.
				load_detail = true,
				-- List order ["modification_time", "creation_time", "filename"]
				load_order = "modification_time",
				-- Configuration for extensions
				extensions = {
					quickfix = {},
				},
			})
			-- Resession does NOTHING automagically, so we have to set up some keymaps
			vim.keymap.set("n", "<leader>ss", resession.save, { desc = "Save session" })
			-- vim.keymap.set("n", "<leader>Sl", resession.load "last", { desc = "Load last session" })
			vim.keymap.set("n", "<leader>sf", resession.load, { desc = "Find session" })
			vim.keymap.set("n", "<leader>sd", resession.delete, { desc = "Delete session" })
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					-- Only load the session if nvim was started with no args
					if vim.fn.argc(-1) == 0 then
						-- Save these to a different directory, so our manual sessions don't get polluted
						resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
					end
				end,
			})
			vim.api.nvim_create_autocmd("VimLeavePre", {
				callback = function()
					resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
				end,
			})
			vim.api.nvim_create_autocmd("VimLeavePre", {
				callback = function()
					-- Always save a special session named "last"
					resession.save("last")
				end,
			})
		end
	},
}
