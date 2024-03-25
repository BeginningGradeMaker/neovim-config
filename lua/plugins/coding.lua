local get_icon = require("utils").get_icon

return {
	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
		},
	},
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		event = "VeryLazy",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			-- require("mini.surround").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		keys = {
			-- { "<leader>/", mode = { "n", "v" }, desc = "Comment toggle linewise" },
			-- { "<leader>?", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
			{
				"<leader>/",
				function()
					require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
				end,
				desc = "Comment toggle linewise",
			},
			{
				"<leader>?",
				function()
					require("Comment.api").toggle.blockwise.count()
				end,
				desc = "Comment toggle blockwise",
			},
		},
		opts = function()
			local commentstring_avail, commentstring =
				pcall(require, "ts_context_commentstring.integrations.comment_nvim")
			return commentstring_avail
					and commentstring
					and {
						pre_hook = commentstring.create_pre_hook(),
						toggler = { line = "<leader>/", block = "<leader>?" },
					}
				or {}
		end,
	},
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6", --recommended as each new version will have breaking changes
		opts = {
			--Config goes here
			tabout = { enable = true },
		},
	},
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	event = "InsertEnter",
	-- 	config = true,
	-- 	-- use opts = {} for passing setup options
	-- 	-- this is equalent to setup({}) function
	-- },
	{
		"abecodes/tabout.nvim",
		lazy = true,
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
				backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
				act_as_tab = true, -- shift content if tab out is not possible
				act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
				default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
				default_shift_tab = "<C-d>", -- reverse shift default action,
				enable_backwards = true, -- well ...
				completion = false, -- if the tabkey is used in a completion pum
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },
				},
				ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
				exclude = {}, -- tabout will ignore these filetypes
			})
		end,
		requires = {
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
		},
		opt = true, -- Set this to true if the plugin is optional
		event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
		priority = 1000,
	},
	{
		"petertriho/nvim-scrollbar",
		event = "VeryLazy",
	},
	{
		"rcarriga/nvim-notify",
		lazy = false,
		config = function()
			vim.notify = require("notify")
			require("notify").setup()
		end,
	},
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>gp",
				"<cmd>Gitsigns preview_hunk<cr>",
				desc = "Gitsigns preview",
			},
			{
				"<leader>ub",
				"<cmd>Gitsigns toggle_current_line_blame<cr>",
				desc = "Toggle git line blame",
			},
		},
		opts = {
			signs = {
				add = { text = get_icon("GitSign") },
				change = { text = get_icon("GitSign") },
				delete = { text = get_icon("GitSign") },
				topdelete = { text = get_icon("GitSign") },
				changedelete = { text = get_icon("GitSign") },
				untracked = { text = get_icon("GitSign") },
			},
		},
	},
	{
		"kawre/leetcode.nvim",
		lazy = true,
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",

			-- optional
			"nvim-treesitter/nvim-treesitter",
			"rcarriga/nvim-notify",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			-- configuration goes here
		},
	},
	{
		"xeluxee/competitest.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = "MunifTanjim/nui.nvim",
		config = function()
			require("competitest").setup({
				compile_command = {
					cpp = { exec = "g++-13", args = { "-O2", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
				},
			})
			vim.keymap.set("n", "<leader>rr", "<cmd>CompetiTest run<cr>", { desc = "Rerun" })
			vim.keymap.set("n", "<leader>rt", "<cmd>CompetiTest receive testcases<cr>", { desc = "Receive testcases" })
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"Tyler-Barham/floating-help.nvim",
		event = "CmdlineEnter",
		config = function()
			local fh = require("floating-help")

			fh.setup({
				-- Defaults
				width = 80, -- Whole numbers are columns/rows
				height = 0.9, -- Decimals are a percentage of the editor
				position = "E", -- NW,N,NW,W,C,E,SW,S,SE (C==center)
				border = "rounded", -- rounded,double,single
				onload = function(query_type) end, -- optional callback to be executed after help contents has been loaded
			})

			-- Create a keymap for toggling the help window
			vim.keymap.set("n", "<F1>", fh.toggle)
			-- Create a keymap to search cppman for the word under the cursor
			vim.keymap.set("n", "<F2>", function()
				fh.open("t=cppman", vim.fn.expand("<cword>"))
			end)
			-- Create a keymap to search man for the word under the cursor
			vim.keymap.set("n", "<F3>", function()
				fh.open("t=man", vim.fn.expand("<cword>"))
			end)

			-- Only replace cmds, not search; only replace the first instance
			local function cmd_abbrev(abbrev, expansion)
				local cmd = "cabbr "
					.. abbrev
					.. ' <c-r>=(getcmdpos() == 1 && getcmdtype() == ":" ? "'
					.. expansion
					.. '" : "'
					.. abbrev
					.. '")<CR>'
				vim.cmd(cmd)
			end

			-- Redirect `:h` to `:FloatingHelp`
			cmd_abbrev("h", "FloatingHelp")
			cmd_abbrev("help", "FloatingHelp")
			cmd_abbrev("helpc", "FloatingHelpClose")
			cmd_abbrev("helpclose", "FloatingHelpClose")
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim", event = "VeryLazy", main = "ibl", opts = {} },
	-- lazy.nvim
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		-- add any options here
	-- 	},
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },
}
