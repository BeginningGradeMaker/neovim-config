return {
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		config = function()
			require("transparent").setup({
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
				on_clear = function()
					require("transparent").clear_prefix("NeoTree")
					-- require("transparent").clear_prefix("lualine")
					require("transparent").clear_prefix("Bufferline")
				end,
			})

			vim.keymap.set("n", "<leader>tp", function()
				-- require("transparent").clear_prefix("lualine")
				vim.cmd("TransparentToggle")
			end, { desc = "Toggle transparent background" })
		end,
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
					-- style = "nvchad",
				},
				blink_cmp = true,
				grug_far = true,
				noice = true,
				notify = true,
				snacks = true,
				lsp_trouble = true,
				which_key = true,
				dropbar = {
					enabled = true,
					color_mode = true, -- enable color for kind's texts, not just kind's icons
				},
			},
		},
		config = function()
			require("catppuccin").setup({ term_colors = true })
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
					["lualine.nvim"] = true,
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
				-- palettes = {
				-- 	global = { -- Globally accessible palettes, theme palettes take priority.
				-- 		my_grey = "#ebebeb",
				-- 		my_color = "#ffffff",
				-- 	},
				-- 	astrodark = { -- Extend or modify astrodarks palette colors
				-- 		ui = {
				-- 			red = "#800010", -- Overrides astrodarks red UI color
				-- 			accent = "#CC83E3", -- Changes the accent color of astrodark.
				-- 		},
				-- 		syntax = {
				-- 			cyan = "#800010", -- Overrides astrodarks cyan syntax color
				-- 			comments = "#CC83E3", -- Overrides astrodarks comment color.
				-- 		},
				-- 		my_color = "#000000", -- Overrides global.my_color
				-- 	},
				-- },
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
	-- {
	-- 	"olimorris/onedarkpro.nvim",
	-- 	priority = 1000, -- ensure it loads first
	-- 	-- config = function()
	-- 	-- 	-- somewhere in your config:
	-- 	-- end,
	-- },
	{
		"navarasu/onedark.nvim",
		priority = 1000,
	},
	{
		"luisiacc/the-matrix.nvim",
		priority = 1000,
	},
	-- {
	-- 	"diegoulloao/neofusion.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("neofusion").setup({
	-- 			transparent_mode = true,
	-- 		})
	-- 	end,
	-- },
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
	{ "marko-cerovac/material.nvim", enabled = vim.g.opt_themes, priority = 1000 },
	{
		"scottmckendry/cyberdream.nvim",
        enabled = vim.g.opt_themes,
		lazy = false,
		priority = 1000,
		config = function()
			local cyberdream = require("cyberdream")
			cyberdream.setup()

			-- Add a custom keybinding to toggle the colorscheme
			vim.api.nvim_set_keymap("n", "<leader>tm", ":CyberdreamToggleMode<CR>", { noremap = true, silent = true })
			-- The event data property will contain a string with either "default" or "light" respectively
			vim.api.nvim_create_autocmd("User", {
				pattern = "CyberdreamToggleMode",
				callback = function(event)
					-- Your custom code here!
					-- For example, notify the user that the colorscheme has been toggled
					print("Switched to " .. event.data .. " mode!")
				end,
			})
		end,
	},
	{
		"projekt0n/github-nvim-theme",
        enabled = vim.g.opt_themes,
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
	},
	{ "rose-pine/neovim", enabled = vim.g.opt_themes, lazy = false, priority = 1000, name = "rose-pine" },
	{
		"AlexvZyl/nordic.nvim",
        enabled = vim.g.opt_themes,
		lazy = true,
		event = "VeryLazy",
		priority = 1000,
		-- config = function()
		-- 	require("nordic").load()
		-- end,
	},
	{
		"Mofiqul/vscode.nvim",
        enabled = vim.g.opt_themes,
		priority = 1000,
	},
	{
		"shaunsingh/nord.nvim",
		priority = 1000,
	},
}
