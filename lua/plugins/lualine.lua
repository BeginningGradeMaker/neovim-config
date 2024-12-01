local icons = require("icons.nerd_font")
return {
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		enabled = true,
		event = "BufReadPre",
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
						"diagnostics",
					},
					lualine_c = {
						-- { "%=" },
						-- {
						-- 	"harpoon2",
						-- 	icon = "♥ ",
						-- 	indicators = { "1", "2", "3", "4" },
						-- 	active_indicators = { "[1]", "[2]", "[3]", "[4]" },
						-- 	-- color_active = { fg = "#7aa2f7" },
						-- 	-- color_active = { fg = "lualine_a_normal.bg" },
						-- 	_separator = " ",
						-- 	no_harpoon = "Harpoon not loaded",
						-- 	-- padding = 50,
						-- },
						-- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{
							function()
								local statusline = require("arrow.statusline")
								return statusline.text_for_statusline_with_icons()
							end,
						},
						-- { "filename", path = 1 },
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = "white",
						},
						{
							function()
								for _, buf in ipairs(vim.api.nvim_list_bufs()) do
									if vim.api.nvim_buf_get_option(buf, "modified") then
										return "Unsaved buffers" -- any message or icon
									end
								end
								return ""
							end,
						},
					},
					lualine_x = {
						{
							require("noice").api.status.mode.get,
							cond = require("noice").api.status.mode.has,
							color = { fg = "#ff9e64" },
						},
						{
							require("noice").api.status.command.get,
							cond = require("noice").api.status.command.has,
							color = { fg = "#ff9e64" },
						},
						"encoding",
						"fileformat",
						"filetype",
					},
				},
				-- winbar = {
				-- 	lualine_a = {},
				-- 	lualine_b = { "filename"},
				-- 	lualine_c = { "filename" },
				-- 	lualine_x = {},
				-- 	lualine_y = {},
				-- 	lualine_z = {},
				-- },

				-- inactive_winbar = {
				-- 	lualine_a = {},
				-- 	lualine_b = {},
				-- 	lualine_c = { {"filename", path = 1} },
				-- 	lualine_x = {},
				-- 	lualine_y = {},
				-- 	lualine_z = {},
				-- },
                refresh = {
                    -- statusline = 50,
                    -- tabline = 10,
                }
			})
		end,
	},
}
