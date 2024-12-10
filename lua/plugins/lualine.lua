return {
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		enabled = true,
		event = { "BufReadPost", "BufNewFile", "BufWritePost" },
		config = function()
			require("lualine").setup({
				options = {
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
						{
							function()
								local statusline = require("arrow.statusline")
								return statusline.text_for_statusline_with_icons()
							end,
						},
					},
					lualine_x = {
						-- { -- macro recording
						-- 	require("noice").api.status.mode.get,
						-- 	cond = require("noice").api.status.mode.has,
						-- 	color = { fg = "#ff9e64" },
						-- },
						-- { -- key strokes
						-- 	require("noice").api.status.command.get,
						-- 	cond = require("noice").api.status.command.has,
						-- 	color = { fg = "#ff9e64" },
						-- },
						"encoding",
						"fileformat",
						"filetype",
					},
				},
                refresh = {
                    statusline = 100,
                }
			})
		end,
	},
}
