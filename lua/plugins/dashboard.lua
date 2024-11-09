return {
	{
		"goolord/alpha-nvim",
		lazy = false,
		priority = 1,
		config = function()
			local dashboard = require("alpha.themes.dashboard")
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaClosed",
				callback = function()
					vim.opt.showtabline = 2
					require("lualine").hide({ unhide = true })
				end,
			})
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					vim.opt.showtabline = 0
					require("lualine").hide()
				end,
			})
			dashboard.section.header.val = {
				"",
				" ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗  █████╗ ██████╗ ██████╗  ",
				" ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔══██╗ ",
				" ██║  ██║███████║███████╗███████║██████╔╝██║   ██║███████║██████╔╝██║  ██║ ",
				" ██║  ██║██╔══██║╚════██║██╔══██║██╔══██╗██║   ██║██╔══██║██╔══██╗██║  ██║ ",
				" ██████╔╝██║  ██║███████║██║  ██║██████╔╝╚██████╔╝██║  ██║██║  ██║██████╔╝ ",
				" ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ",
				"",
			}
			dashboard.section.header.opts.hl = "DashboardHeader"
			dashboard.section.footer.opts.hl = "DashboardFooter"
			local button, get_icon = require("utils").alpha_button, require("utils").get_icon
			dashboard.section.buttons.val = {
				button("LDR n  ", get_icon("FileNew", 2, true) .. "New File  "),
				button("LDR LDR", get_icon("Search", 2, true) .. "Find File  "),
				button("LDR f k", get_icon("DefaultFile", 2, true) .. "Keymaps  "),
				button("LDR f w", get_icon("WordFile", 2, true) .. "Find Word  "),
				-- button("LDR f '", get_icon("Bookmarks", 2) .. "Bookmarks  "),
				button("LDR S .", get_icon("Refresh", 2) .. "Load Current Session  "),
				button("LDR e  ", get_icon("Tab", 2) .. "File Tree  "),
			}

			dashboard.config.layout = {
				{ type = "padding", val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) }) },
				dashboard.section.header,
				{ type = "padding", val = 5 },
				dashboard.section.buttons,
				{ type = "padding", val = 3 },
				dashboard.section.footer,
			}
			-- dashboard.config.opts.noautocmd = true
			require("alpha").setup(dashboard.config)
			vim.keymap.set("n", "<leader>H", function()
				local wins = vim.api.nvim_tabpage_list_wins(0)
				if #wins > 1 and vim.bo[vim.api.nvim_win_get_buf(wins[1])].filetype == "neo-tree" then
					vim.fn.win_gotoid(wins[2]) -- go to non-neo-tree window to toggle alpha
				end
				require("alpha").start(false)
			end, { desc = "Home screen" })
			-- require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
			-- vim.cmd.colorscheme("tokyonight")
            require("colorscheme")
		end,
	},
}
