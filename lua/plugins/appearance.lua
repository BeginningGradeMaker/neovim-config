return {
	{
		"folke/drop.nvim",
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>xs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"folke/noice.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			cmdline = {
				view = "cmdline",
			},
			messages = {
				-- NOTE: If you enable messages, then the cmdline is enabled automatically.
				-- This is a current Neovim limitation.
				enabled = true, -- enables the Noice messages UI
				view = false, -- default view for messages
				view_error = "notify", -- view for errors
				view_warn = "notify", -- view for warnings
				view_history = "messages", -- view for :messages
				view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			}, -- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
	},
	{
		"Xuyuanp/scrollbar.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("scrollbar").show()
		end,
	},
	{
		"rcarriga/nvim-notify",
		lazy = false,
		-- keys = {
		-- 	{
		-- 		"<leader><leader>",
		-- 		function()
		-- 			-- vim.api.nvim_feedkeys("<Esc>", 'n', true)
		-- 			require("notify").dismiss({ silent = true, pending = true })
		-- 		end,
		-- 		{ noremap = true, desc = "Dimiss Notify" },
		-- 	},
		-- },
		config = function()
			vim.notify = require("notify")
			-- require("notify").setup({ background_colour = "#000000" })
			require("notify").setup({
                -- background_colour = "#111100"
            })
			vim.keymap.set("n", "<leader>R", function()
				require("notify").dismiss({ silent = true, pending = true })
			end, { desc = "Dimiss notification" })
		end,
	},
	{
		"nvchad/volt",
		lazy = true,
	},
	{
		"nvchad/menu",
		lazy = false,
		config = function()
			vim.keymap.set("n", "<RightMouse>", function()
				vim.cmd.exec('"normal! \\<RightMouse>"')

				local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
				require("menu").open(options, { mouse = true })
			end, {})
		end,
	},
}
