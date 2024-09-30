return {
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					-- 	-- theme = "dracula",
					-- 	-- theme = 'material deep ocean'
					-- theme = "tokyonight",
					-- 	-- always_divide_middle = false,
					-- 	-- theme = require("neofusion.lualine"),
					theme = "auto",
					component_separators = { left = "", right = "" },
				},
				sections = {
					lualine_b = {
						"branch",
						"diagonostics",
					},
					lualine_c = {
						-- { "%=" },
						{
							"harpoon2",
							icon = "♥ ",
							indicators = { "1", "2", "3", "4" },
							active_indicators = { "[1]", "[2]", "[3]", "[4]" },
							color_active = { fg = "#7aa2f7" },
							_separator = " ",
							no_harpoon = "Harpoon not loaded",
							-- padding = 50,
						},
					},
				},
			})
		end,
	},
	{
		"rebelot/heirline.nvim",
		lazy = false,
		require("heirline").setup({
			statusline = { ... },
			winbar = { ... },
			tabline = { ... },
			statuscolumn = { ... },
		}),
	},
}
