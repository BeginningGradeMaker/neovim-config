-- local get_icon = require("utils").get_icon

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

			require("mini.pairs").setup({
				mappings = {
					-- ["<"] = { action = "open", pair = "<>", neigh_pattern = "[^\\]." },
					-- [">"] = { action = "close", pair = "<>", neigh_pattern = "[^\\]." },
					-- ["*"] = { action = "closeopen", pair = "**", neigh_pattern = "[^\\]." },
					["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\$)].', register = { cr = false } },
				},
			})

			require("mini.icons").setup()

			require("mini.surround").setup({
				-- Number of lines within which surrounding is searched
				n_lines = 20,
			})

			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
	-- "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	-- {
	-- 	"altermo/ultimate-autopair.nvim",
	-- 	event = { "InsertEnter", "CmdlineEnter" },
	-- 	branch = "v0.6", --recommended as each new version will have breaking changes
	-- 	opts = {
	-- 		--Config goes here
	-- 		tabout = { enable = true },
	-- 	},
	-- },
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
				tabkey = "",      -- key to trigger tabout, set to an empty string to disable
				backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
				act_as_tab = true, -- shift content if tab out is not possible
				act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
				default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
				default_shift_tab = "<C-d>", -- reverse shift default action,
				enable_backwards = true, -- well ...
				completion = true, -- if the tabkey is used in a completion pum
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
		opt = true,        -- Set this to true if the plugin is optional
		event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
		priority = 1000,
	},
	{
		"kawre/neotab.nvim",
		event = "InsertEnter",
		opts = {
			-- configuration goes here
			tabkey = "<Tab>",
			behavior = "closing",
			pairs = {
				{ open = "(", close = ")" },
				{ open = "[", close = "]" },
				{ open = "{", close = "}" },
				{ open = "'", close = "'" },
				{ open = '"', close = '"' },
				{ open = "`", close = "`" },
				{ open = "<", close = ">" },
				-- For typst
				{ open = "$", close = "$" },
				{ open = "_", close = "_" },
				{ open = "*", close = "*" },
			},
		},
		opt = true, -- Set this to true if the plugin is optional
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
			-- require("notify").setup({ background_colour = "#000000" })
			require("notify").setup()
		end,
	},
	{
		"xeluxee/competitest.nvim",
		lazy = true,
		ft = { "cpp" },
		dependencies = "MunifTanjim/nui.nvim",
		config = function()
			require("competitest").setup({
				compile_command = {
					cpp = { exec = "g++-13", args = {"-std=c++20", "-O2", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
				},
				-- runner_ui = { interface = "split" },
			})
			vim.keymap.set("n", "<leader>rr", "<cmd>CompetiTest run<cr>", { desc = "Rerun" })
			vim.keymap.set("n", "<leader>rt", "<cmd>CompetiTest receive testcases<cr>", { desc = "Receive testcases" })
			vim.keymap.set("n", "<leader>ru", "<cmd>CompetiTest show_ui<cr>", { desc = "Show UI" })
		end,
	},
	-- {
	-- 	"kylechui/nvim-surround",
	-- 	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("nvim-surround").setup({
	-- 			-- Configuration here, or leave empty to use defaults
	-- 		})
	-- 	end,
	-- },
	{ "lukas-reineke/indent-blankline.nvim", event = "VeryLazy", main = "ibl", opts = {} },
	-- {
	-- 	"folke/noice.nvim",
	-- 	lazy = false,
	-- 	-- event = "VeryLazy",
	-- 	opts = {
	-- 		cmdline = {
	-- 			view = "cmdline",
	-- 		},
	-- 		lsp = {
	-- 			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	-- 			override = {
	-- 				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 				["vim.lsp.util.stylize_markdown"] = true,
	-- 				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
	-- 			},
	-- 		},
	-- 		-- you can enable a preset for easier configuration
	-- 		presets = {
	-- 			bottom_search = true, -- use a classic bottom cmdline for search
	-- 			command_palette = true, -- position the cmdline and popupmenu together
	-- 			long_message_to_split = true, -- long messages will be sent to a split
	-- 			inc_rename = false, -- enables an input dialog for inc-rename.nvim
	-- 			lsp_doc_border = true, -- add a border to hover docs and signature help
	-- 		},                    -- add any options here
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
	{

		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				char = {
					jump_labels = true,
				},
			},
		},
		-- stylua: ignore
		keys = {
			-- { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			{ "S",     mode = { "n", "x", "o" }, function() require("flash").jump() end,        desc = "Flash" },
			{ "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
			{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
		},
	},
	{
		"mistricky/codesnap.nvim",
		build = "make build_generator",
		keys = {
			{ "<leader>cc", "<cmd>CodeSnap<cr>",     mode = "x", desc = "Save selected code snapshot into clipboard" },
			{ "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
		},
		opts = {
			save_path = "~/Pictures",
			has_breadcrumbs = true,
			bg_theme = "bamboo",
			mac_window_bar = true,
			title = "Zhisu Wang",
			code_font_family = "CaskaydiaCove Nerd Font",
			watermark_font_family = "Pacifico",
			watermark = "Zhisu Wang",
			breadcrumbs_separator = "/",
			has_line_number = true,
			show_workspace = false,
			min_width = 0,
			bg_x_padding = 100,
			bg_y_padding = 82,
		},
	},
	{
		"mgrabovsky/vim-xverif",
	},
}
