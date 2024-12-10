return {
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		config = function()
			local transparent = require("transparent")
			transparent.setup({
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

			vim.g.toggle
				.new({
					name = "Transparent Background",
					get = function()
						return vim.g.transparent_enabled
					end,
					set = function(state)
						transparent.toggle(state)
					end,
				})
				:map("<leader>up")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
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
				mini = {
					enabled = true,
					indentscope_color = "",
				},
			},
		},
		config = function()
			require("catppuccin").setup({ term_colors = true })
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
        enabled = vim.g.opt_themes,
		priority = 1000,
	},
    { "diegoulloao/neofusion.nvim", enabled = vim.g.opt_themes, priority = 1000 , config = true, },
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
    { "projekt0n/github-nvim-theme", enabled = vim.g.opt_themes, priority = 1000, },
	{ "sainnhe/gruvbox-material", enabled = vim.g.opt_themes, priority = 1000, },
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
	{ "rose-pine/neovim", enabled = vim.g.opt_themes, lazy = false, priority = 1000, name = "rose-pine" },
	{
		"shaunsingh/nord.nvim",
        enabled = vim.g.opt_themes,
		priority = 1000,
	},
	{
		"rebelot/kanagawa.nvim",
        enabled = vim.g.opt_themes,
		priority = 1000,
	},
}
