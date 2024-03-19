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

			-- require("mini.pairs").setup({
			--     mappings = {
			--         -- ["<"] = { action = "open", pair = "<>", neigh_pattern = "[^\\]." },
			--         -- [">"] = { action = "close", pair = "<>", neigh_pattern = "[^\\]." },
			--         -- ["*"] = { action = "closeopen", pair = "**", neigh_pattern = "[^\\]." },
			--         ["'"] = {
			--             action = "closeopen",
			--             pair = "''",
			--             neigh_pattern = "[^%a\\$)].",
			--             register = { cr = false },
			--         },
			--         ["$"] = {
			--             action = "closeopen",
			--             pair = "$$",
			--             neigh_pattern = "[^%a\\$)].",
			--             register = { cr = false },
			--         },
			--     },
			-- })

			require("mini.icons").setup()

			require("mini.surround").setup({
				-- Number of lines within which surrounding is searched
				n_lines = 20,
			})
			-- vim.keymap.set("n", "s", "<Nop>", { silent = true })

			-- local statusline = require("mini.statusline")
			-- statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			-- statusline.section_location = function()
			-- 	return "%2l:%-2v"
			-- end
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
				tabkey = "", -- key to trigger tabout, set to an empty string to disable
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
		opt = true, -- Set this to true if the plugin is optional
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
			require("notify").setup()
            vim.keymap.set("n", "<leader><leader>", function() require("notify").dismiss({silent = true, pending = true}) end, {desc = "Dimiss notification"})
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
					cpp = { exec = "g++-14", args = { "-std=c++20", "-O2", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
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
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter_search() end,              desc = "Treesitter search" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
	},
	-- {
	-- 	"mistricky/codesnap.nvim",
	-- 	build = "make build_generator",
	--        lazy = false,
	--        event = "VeryLazy",
	-- 	keys = {
	-- 		{ "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
	-- 		{ "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
	-- 	},
	-- 	opts = {
	-- 		save_path = "~/Pictures",
	-- 		has_breadcrumbs = true,
	-- 		bg_theme = "bamboo",
	-- 		mac_window_bar = true,
	-- 		title = "Zhisu Wang",
	-- 		code_font_family = "CaskaydiaCove Nerd Font",
	-- 		watermark_font_family = "Pacifico",
	-- 		watermark = "Zhisu Wang",
	-- 		breadcrumbs_separator = "/",
	-- 		has_line_number = true,
	-- 		show_workspace = false,
	-- 		min_width = 0,
	-- 		bg_x_padding = 100,
	-- 		bg_y_padding = 82,
	-- 	},
	-- },
	-- {
	-- 	"mgrabovsky/vim-xverif",
	-- },
	{
		"github/copilot.vim",
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
	-- {
	-- 	"lewis6991/hover.nvim",
	-- 	config = function()
	-- 		require("hover").setup({
	-- 			init = function()
	-- 				require("hover.providers.lsp")
	-- 				-- require('hover.providers.gh')
	-- 				-- require('hover.providers.gh_user')
	-- 				-- require('hover.providers.jira')
	-- 				-- require('hover.providers.dap')
	-- 				-- require('hover.providers.fold_preview')
	-- 				require("hover.providers.diagnostic")
	-- 				-- require('hover.providers.man')
	-- 				-- require('hover.providers.dictionary')
	-- 			end,
	-- 			preview_opts = {
	-- 				border = "single",
	-- 			},
	-- 			-- Whether the contents of a currently open hover window should be moved
	-- 			-- to a :h preview-window when pressing the hover keymap.
	-- 			preview_window = false,
	-- 			title = true,
	-- 			mouse_providers = {
	-- 				"LSP",
	-- 			},
	-- 			mouse_delay = 500,
	-- 		})
	--
	-- 		-- Mouse support
	-- 		vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
	-- 		vim.o.mousemoveevent = true
	-- 	end,
	-- },
	{
		"mbbill/undotree",
		lazy = true,
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })
		end,
	},
	{
		"gbprod/yanky.nvim",
		lazy = true,
		event = "VeryLazy",
		keys = {
			{
				"<leader>p",
				function()
					require("telescope").extensions.yank_history.yank_history({})
				end,
				desc = "Open Yank History",
			},
			-- { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
			-- { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
			-- { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
			-- { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
			-- { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
			-- { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
			-- { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
			-- { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
			-- { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
			-- { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
			-- { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
			-- { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
			-- { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
			-- { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
			-- { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
			-- { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
			-- { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
		},
	},
}
