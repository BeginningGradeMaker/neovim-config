return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"folke/tokyonight.nvim",
	},
	lazy = true,
	event = "VeryLazy",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				auto_toggle_bufferline = false,
				style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,
				close_command = "bdelete %d",
				indicator = {
					style = "none",
				},
				-- name_formatter = function(buf)
				-- 	if buf.name:match("%.*") then
				-- 		return vim.fn.fnamemodify(buf.name, ":t:r")
				-- 	end
				-- end,
				-- diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local icon = level:match("error") and " " or " "
					return icon .. count
				end,
				offsets = { { filetype = "neo-tree", text = "Neotree", text_align = "center" } },
				enforce_regular_tabs = true,
				tab_size = 12,
				TabLineFill = { bg = bufferline.line_bg },
			},
		})
		local show = true
		vim.keymap.set("n", "<leader>tl", function()
			if show then
				vim.opt.showtabline = 0
				show = false
			else
				vim.opt.showtabline = 2
				show = true
			end
		end, { desc = "Toggle bufferline" })
	end,
}
