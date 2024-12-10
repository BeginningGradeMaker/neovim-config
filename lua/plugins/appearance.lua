return {
	{
		"folke/noice.nvim",
		lazy = true,
		enabled = true,
		event = "VeryLazy",
        keys = {
            {
                "<leader>h",
                "<cmd>NoiceHistory<cr>",
                desc = "Notification history",
            }
        },
		opts = {
			cmdline = {
				view = "cmdline_popup",
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
		},
	},
	{
		"dstein64/nvim-scrollview",
        enabled = not vim.g.neovide, -- existing bug with neovide
		lazy = true,
		event = "VeryLazy",
	       opts = {
	           signs_on_startup = {},
	       },
	},
	-- Enable these if you want mosue support with pretty UI
	-- {
	--     "nvzone/typr",
	--     dependencies = {
	--         		"nvchad/volt",
	--     }
	-- },
	-- {
	-- 	"nvzone/minty",
	-- 	cmd = { "Shades", "Huefy" },
	-- },
	-- {
	-- 	"nvchad/menu",
	-- 	lazy = false,
	-- 	config = function()
	-- 		vim.keymap.set("n", "<RightMouse>", function()
	-- 			vim.cmd.exec('"normal! \\<RightMouse>"')
	--
	-- 			local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
	-- 			require("menu").open(options, { mouse = true })
	-- 		end, {})
	-- 	end,
	-- },
	{
		"Bekaboo/dropbar.nvim",
		lazy = false,
		event = { "BufReadPost", "BufNewFile", "BufWritePost" },
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
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		opts = function()
			Snacks.toggle({
				name = "Indention Guides",
				get = function()
					return require("ibl.config").get_config(0).enabled
				end,
				set = function(state)
					require("ibl").setup_buffer(0, { enabled = state })
				end,
			}):map("<leader>ug")

			return {
				indent = {
					char = "│",
					tab_char = "│",
				},
				scope = { show_start = false, show_end = false, highlight = "Special" },
				exclude = {
					filetypes = {
						"Trouble",
						"alpha",
						"dashboard",
						"help",
						"lazy",
						"mason",
						"neo-tree",
						"notify",
						"snacks_dashboard",
						"snacks_notif",
						"snacks_terminal",
						"snacks_win",
						"toggleterm",
						"trouble",
					},
				},
			}
		end,
	},
}
