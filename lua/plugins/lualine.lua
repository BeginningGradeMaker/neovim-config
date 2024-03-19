return {
	{
		"nvim-lualine/lualine.nvim",
        lazy = true,
        event = "VeryLazy",
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local hl = vim.api.nvim_get_hl(0, { name = "lualine_a_normal", create = true })

			-- Convert the color values to hex
			-- local guifg = string.format("#%06x", hl.foreground)
			-- local guibg = string.format("#%06x", hl.bg)

			require("lualine").setup({
				options = {
					-- 	-- theme = "dracula",
					-- 	-- theme = 'material deep ocean'
					-- theme = "tokyonight",
					-- 	-- always_divide_middle = false,
					-- 	-- theme = require("neofusion.lualine"),
					theme = "auto",
					component_separators = { left = "", right = "" },
				},
				globalstatus = true,
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
							-- color_active = { fg = "#7aa2f7" },
							-- color_active = { fg = "lualine_a_normal.bg" },
							_separator = " ",
							no_harpoon = "Harpoon not loaded",
							-- padding = 50,
						},
						-- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						"filename",
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = "white"
						},
					},
				},
			})
		end,
	},
}
