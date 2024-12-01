return {
	{
		"folke/drop.nvim",
		enabled = false,
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>xs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"folke/noice.nvim",
		lazy = true,
		enabled = true,
		event = "VeryLazy",
		opts = {
			cmdline = {
				view = "cmdline",
				-- view = "cmdline_popup",
			},
			messages = {
				-- NOTE: If you enable messages, then the cmdline is enabled automatically.
				-- This is a current Neovim limitation.
				enabled = true, -- enables the Noice messages UI
				view = "notify", -- default view for messages
				view_error = "notify", -- view for errors
				view_warn = "notify", -- view for warnings
				view_history = "messages", -- view for :messages
				view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			}, -- add any options here
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "change",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "line",
					},
					opts = { skip = true },
				},
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
	},
	-- {
	-- 	"Xuyuanp/scrollbar.nvim",
	-- 	lazy = true,
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("scrollbar").show()
	-- 	end,
	-- },
	{
		"rcarriga/nvim-notify",
		lazy = false,
		-- keys = {
		-- 	{
		-- 		"<leader><leader>",
		-- 		function()
		-- 			-- vim.api.nvim_feedkeys("<Esc>", 'n', true)
		-- 			require("notify").dismiss({ silent = true, pending = true })
		-- 		end,
		-- 		{ noremap = true, desc = "Dimiss Notify" },
		-- 	},
		-- },
		config = function()
			vim.notify = require("notify")
			-- require("notify").setup({ background_colour = "#000000" })
			require("notify").setup({
				-- background_colour = "#111100"
			})
			vim.keymap.set("n", "<leader>R", function()
				require("notify").dismiss({ silent = true, pending = true })
			end, { desc = "Dimiss notification" })
		end,
	},
	{
		"nvchad/volt",
		lazy = true,
	},
	{
		"nvchad/menu",
		lazy = false,
		config = function()
			vim.keymap.set("n", "<RightMouse>", function()
				vim.cmd.exec('"normal! \\<RightMouse>"')

				local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
				require("menu").open(options, { mouse = true })
			end, {})
		end,
	},
	{
		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		opts = {
			sources = {
				path = {
                    -- Change winbar status when file is modified
					modified = function(sym)
						return sym:merge({
							name = sym.name .. "[+]",
							icon = " ",
							name_hl = "DiffAdded",
							icon_hl = "DiffAdded",
							-- ...
						})
					end,
				},
			},
		},
	},
	-- {
	-- 	"akinsho/toggleterm.nvim",
	-- 	lazy = true,
	-- 	cmd = { "ToggleTerm", "TermExec" },
	-- 	keys = {
	-- 		{ "<c-\\>" },
	-- 	},
	-- 	config = function()
	-- 		local get_height = function()
	-- 			return math.floor(vim.o.lines * 0.70)
	-- 		end
	-- 		local get_width = function()
	-- 			return math.floor(vim.o.columns * 0.80 - 1)
	-- 		end
	-- 		require("toggleterm").setup({
	-- 			-- size can be a number or function which is passed the current terminal
	-- 			size = get_height,
	-- 			open_mapping = [[<c-\>]],
	-- 			hide_numbers = true, -- hide the number column in toggleterm buffers
	-- 			shade_terminals = true,
	-- 			-- shading_factor = 1,       -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	-- 			start_in_insert = true,
	-- 			insert_mappings = true, -- whether or not the open mapping applies in insert mode
	-- 			autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
	-- 			terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	-- 			-- persist_size = true,
	-- 			direction = "float",
	-- 			close_on_exit = true, -- close the terminal window when the process exits
	-- 			shell = vim.o.shell, -- change the default shell
	-- 			float_opts = {
	-- 				width = get_width,
	-- 				height = get_height,
	-- 				border = "rounded",
	-- 			},
	-- 			highlights = {
	-- 				-- highlights which map to a highlight group name and a table of it's values
	-- 				-- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
	-- 				-- Normal = {
	-- 				--   link = 'Pmenu'
	-- 				-- },
	-- 				-- NormalFloat = {
	-- 				--   link = 'Pmenu'
	-- 				-- },
	-- 				-- FloatBorder = {
	-- 				--   link = 'Pmenu'
	-- 				-- },
	-- 			},
	-- 			winbar = {
	-- 				enabled = true,
	-- 				name_formatter = function(term) --  term: Terminal
	-- 					local buf_name = vim.api.nvim_buf_get_name(term.bufnr)
	-- 					if not buf_name then
	-- 						return term.name
	-- 					end
	-- 					local buf_len = string.len(buf_name)
	-- 					local colon_index = buf_name:match("^.*():")
	-- 					local slash_index = buf_name:match("^.*()/")
	-- 					local sub_index
	-- 					if colon_index then
	-- 						sub_index = colon_index
	-- 					elseif slash_index then
	-- 						sub_index = slash_index
	-- 					end
	-- 					if sub_index then
	-- 						buf_name = buf_name:sub(sub_index + 1, buf_len)
	-- 					end
	-- 					term.name = buf_name
	-- 					return buf_name
	-- 				end,
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
