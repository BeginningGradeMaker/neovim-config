return {
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		keys = {
			{
				"<leader>tp",
				":TransparentToggle<cr>",
				{ desc = "Transparent background", silent = true },
			},
		},
		opts = {
			groups = { -- table: default groups
				"Normal",
				"NormalNC",
				"Comment",
				"Constant",
				"Special",
				"Identifier",
				"Statement",
				"PreProc",
				"Type",
				"Underlined",
				"Todo",
				"String",
				"Function",
				"Conditional",
				"Repeat",
				"Operator",
				"Structure",
				"LineNr",
				"NonText",
				"SignColumn",
				"CursorLine",
				"CursorLineNr",
				"StatusLine",
				"StatusLineNC",
				"EndOfBuffer",
			},
			extra_groups = {}, -- table: additional groups that should be cleared
			exclude_groups = {}, -- table: groups you don't want to clear
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			color_overrides = {
				mocha = {
					base = "#000000",
					mantle = "#000000",
					crust = "#000000",
				},
			},
			integrations = {
				telescope = {
					enabled = true,
					style = "nvchad",
				},
			},
		},
		config = function()
			require("catppuccin").setup({})
			-- vim.cmd.colorscheme "catppuccin"
		end,
	},
	{
		"AstroNvim/astrotheme",
		priority = 1000,
		config = function()
			require("astrotheme").setup({
				style = {
					transparent = false, -- Bool value, toggles transparency.
					inactive = true, -- Bool value, toggles inactive window color.
					float = true, -- Bool value, toggles floating windows background colors.
					neotree = true, -- Bool value, toggles neo-trees background color.
					border = true, -- Bool value, toggles borders.
					title_invert = true, -- Bool value, swaps text and background colors.
					italic_comments = true, -- Bool value, toggles italic comments.
					-- simple_syntax_colors = true, -- Bool value, simplifies the amounts of colors used for syntax highlighting.
				},
				plugins = { -- Allows for individual plugin overrides using plugin name and value from above.
					["bufferline.nvim"] = true,
					["nvim-treesitter"] = true,
					["dashboard-nvim"] = true,
					["telescope.nvim"] = true,
				},
				integrations = {
					telescope = {
						enabled = true,
						style = "nvchad",
					},
				},
				-- highlights = {
				--   global = { -- Add or modify hl groups globally, theme specific hl groups take priority.
				--     modify_hl_groups = function(hl, c)
				--       hl.PluginColor4 = { fg = c.my_grey, bg = c.none }
				--     end,
				--     ["@String"] = { fg = "#ff00ff", bg = "NONE" },
				--   },
				--   astrodark = {
				--     -- first parameter is the highlight table and the second parameter is the color palette table
				--     modify_hl_groups = function(hl, c) -- modify_hl_groups function allows you to modify hl groups,
				--       hl.Comment.fg = c.my_color
				--       hl.Comment.italic = true
				--     end,
				--     ["@String"] = { fg = "#ff00ff", bg = "NONE" },
				--   },
				-- },
			})
		end,
	},
	{
		"AlexvZyl/nordic.nvim",
		priority = 1000,
		config = function()
			require("nordic").load()
		end,
	},
	{
		"sainnhe/sonokai",
		priority = 1000, -- ensure it loads first
	},
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- ensure it loads first
		-- config = function()
		-- 	-- somewhere in your config:
		-- end,
	},
	{
		"luisiacc/the-matrix.nvim",
		priority = 1000,
	},
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
	},
	{
		"diegoulloao/neofusion.nvim",
		priority = 1000,
		config = function()
			require("neofusion").setup({
				transparent_mode = true,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = false,
			styles = {
				sidebars = "transparent",
				-- floats = "transparent",
			},
			sections = {
				lualine_a = {
					{
						"buffers",
						show_filename_only = true, -- Shows shortened relative path when set to false.
						hide_filename_extension = false, -- Hide filename extension when set to true.
						show_modified_status = true, -- Shows indicator when the buffer is modified.

						mode = 0, -- 0: Shows buffer name
						-- 1: Shows buffer index
						-- 2: Shows buffer name + buffer index
						-- 3: Shows buffer number
						-- 4: Shows buffer name + buffer number

						max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
						-- it can also be a function that returns
						-- the value of `max_length` dynamically.
						filetype_names = {
							TelescopePrompt = "Telescope",
							dashboard = "Dashboard",
							packer = "Packer",
							fzf = "FZF",
							alpha = "Alpha",
						}, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

						-- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
						use_mode_colors = false,

						buffers_color = {
							-- Same values as the general color option can be used here.
							active = "lualine_{section}_normal", -- Color for active buffer.
							inactive = "lualine_{section}_inactive", -- Color for inactive buffer.
						},

						symbols = {
							modified = " ●", -- Text to show when the buffer is modified
							alternate_file = "#", -- Text to show to identify the alternate file
							directory = "", -- Text to show when the buffer is a directory
						},
					},
				},
			},
		},
	},
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
}
