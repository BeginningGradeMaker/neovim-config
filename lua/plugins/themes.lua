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
			sections = {},
		},
	},
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{ "marko-cerovac/material.nvim", priority = 1000 },
}
