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
		enabled = true,
		event = "VeryLazy",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			local ai = require("mini.ai")
			ai.setup({
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					m = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					-- i = LazyVim.mini.ai_indent, -- indent
					-- g = LazyVim.mini.ai_buffer, -- buffer
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			})

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
			vim.keymap.set("v", ")", "sa)", { remap = true })
			vim.keymap.set("v", "]", "sa]", { remap = true })
			vim.keymap.set("v", '"', 'sa"', { remap = true })
			vim.keymap.set("v", "'", "sa'", { remap = true })
			vim.keymap.set("v", "}", "sa}", { remap = true })
			vim.keymap.set("v", "$", "sa}", { remap = true })
			-- vim.keymap.set("v", ">", "sa>", { remap = true })
			-- vim.keymap.set("n", "s", "<Nop>", { silent = true })

			local operator = require("mini.operators")
			operator.setup({
				-- Each entry configures one operator.
				-- `prefix` defines keys mapped during `setup()`: in Normal mode
				-- to operate on textobject and line, in Visual - on selection.

				-- Evaluate text and replace with output
				evaluate = {
					prefix = "g=",

					-- Function which does the evaluation
					func = nil,
				},

				-- Exchange text regions
				exchange = {
					prefix = "gx",

					-- Whether to reindent new text to match previous indent
					reindent_linewise = true,
				},

				-- Multiply (duplicate) text
				multiply = {
					prefix = "gm",

					-- Function which can modify text before multiplying
					func = nil,
				},

				-- Replace text with register
				replace = {
					prefix = "gt",

					-- Whether to reindent new text to match previous indent
					reindent_linewise = true,
				},

				-- Sort text
				sort = {
					prefix = "gs",

					-- Function which does the sort
					func = nil,
				},
			})

			require("mini.files").setup({
				mappings = {
					-- close = "<ESC>",
				},
				windows = {
					preview = true,
					width_focus = 30,
					width_preview = 30,
				},
			})
			vim.keymap.set("n", "<leader>e", MiniFiles.open, { desc = "Open file explorer" })
			vim.keymap.set("n", "<leader>E", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0))
			end, { desc = "Open file explorer" })

			local show_dotfiles = true
			local filter_show = function(fs_entry)
				return true
			end
			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end

			local toggle_dotfiles = function()
				show_dotfiles = not show_dotfiles
				local new_filter = show_dotfiles and filter_show or filter_hide
				require("mini.files").refresh({ content = { filter = new_filter } })
			end

			local files_set_cwd = function()
				local cur_entry_path = MiniFiles.get_fs_entry().path
				local cur_directory = vim.fs.dirname(cur_entry_path)
				if cur_directory ~= nil then
					vim.fn.chdir(cur_directory)
				end
			end

			-- extra mappings for mini.files
			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local map_buf = function(lhs, rhs, desc)
						vim.keymap.set("n", lhs, rhs, { buffer = args.data.buf_id, desc = desc or "" })
					end

					map_buf("<leader>e", MiniFiles.close)
					map_buf("<ESC>", MiniFiles.close)
                    map_buf("g.", toggle_dotfiles, "Toggle hidden files")
                    map_buf("gc", files_set_cwd, "Set cwd")

					-- Add extra mappings from *MiniFiles-examples*
				end,
			})

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
	{ "lukas-reineke/indent-blankline.nvim", event = "VeryLazy", main = "ibl", opts = {} },
	{

		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				char = {
					jump_labels = true,
					label = { exclude = "hjkliardcxK" },
					-- keys = { "f", "F", ";", "," },
				},
			},
			label = {
				exclude = "xK",
			},
		},
        -- stylua: ignore
        keys = {
            -- { "s",     mode = { "n", "x", "o" }, ";",              {desc = "Flash", noremap = true, silent = true} },
            -- {"<leader>;", mode = {"n"}, ";", {noremap = false, silent = true }},
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter_search() end,              desc = "Treesitter search" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
	},
	{
		"mbbill/undotree",
		lazy = true,
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle, { desc = "Undotree" })
		end,
	},
	{
		"MagicDuck/grug-far.nvim",
		opts = { headerMaxWidth = 80 },
		cmd = "GrugFar",
		keys = {
			{
				"<leader>fr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
		},
		config = function()
			require("grug-far").setup()
			vim.g.maplocalleader = "."
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = {
				enabled = true,
				preset = {
					header = [[
 I use                                                             
      ████ ██████           █████      ██                 btw
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
                    ]],
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{
							icon = " ",
							key = "g",
							desc = "Find Text",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			scratch = {
				enabled = true,
			},
		},
		keys = {
			{
				"<leader>W",
				function()
					Snacks.bufdelete()
				end,
				desc = "Close buffer",
			},
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>gb",
				function()
					Snacks.git.blame_line()
				end,
				desc = "Git Blame Line",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
			},
			{
				"<leader>gf",
				function()
					Snacks.lazygit.log_file()
				end,
				desc = "Lazygit Current File History",
			},
			{
				"<leader>gl",
				function()
					Snacks.lazygit.log()
				end,
				desc = "Lazygit Log (cwd)",
			},
			{
				"<leader>cR",
				function()
					Snacks.rename()
				end,
				desc = "Rename File",
			},
			{
				"<c-/>",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"<c-_>",
				function()
					Snacks.terminal()
				end,
				desc = "which_key_ignore",
			},
			{
				"]r",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next Reference",
			},
			{
				"[r",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Prev Reference",
			},
			{
				"<C-.>",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>fS",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map("<leader>uc")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle
						.option("background", { off = "light", on = "dark", name = "Dark Background" })
						:map("<leader>ub")
					Snacks.toggle.inlay_hints():map("<leader>uh")
				end,
			})
			vim.api.nvim_create_autocmd("User", {
				pattern = "SnacksDashboardOpened",
				callback = function()
					local hl = vim.api.nvim_get_hl(0, { name = "Cursor", create = true })
					hl.blend = 100
					vim.api.nvim_set_hl(0, "Cursor", hl)
					vim.cmd("set guicursor+=a:Cursor/lCursor")
				end,
			})
			vim.api.nvim_create_autocmd("User", {
				pattern = "SnacksDashboardClosed",
				callback = function()
					local hl = vim.api.nvim_get_hl(0, { name = "Cursor", create = true })
					hl.blend = 0
					vim.api.nvim_set_hl(0, "Cursor", hl)
					-- vim.opt.guicursor.append("a:Cursor/lCursor")
					vim.cmd("set guicursor+=a:Cursor/lCursor")
				end,
			})
		end,
	},
	{
		"hedyhli/outline.nvim",
		enabled = true,
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			-- Your setup opts here
		},
	},
	{
		"danymat/neogen",
		enabled = true,
		lazy = true,
		keys = {
			{
				"<leader>ag",
				":Neogen<cr>",
				desc = "Generate annotations",
				silent = true,
			},
		},
		config = true,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
	},
	{
		"ThePrimeagen/refactoring.nvim",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ "<leader>r", "", desc = "+refactor", mode = { "n", "v" } },
			{
				"<leader>rs",
				pick,
				mode = "v",
				desc = "Refactor",
			},
			{
				"<leader>ri",
				function()
					require("refactoring").refactor("Inline Variable")
				end,
				mode = { "n", "v" },
				desc = "Inline Variable",
			},
			{
				"<leader>rb",
				function()
					require("refactoring").refactor("Extract Block")
				end,
				desc = "Extract Block",
			},
			{
				"<leader>rf",
				function()
					require("refactoring").refactor("Extract Block To File")
				end,
				desc = "Extract Block To File",
			},
			{
				"<leader>rP",
				function()
					require("refactoring").debug.printf({ below = false })
				end,
				desc = "Debug Print",
			},
			{
				"<leader>rp",
				function()
					require("refactoring").debug.print_var({ normal = true })
				end,
				desc = "Debug Print Variable",
			},
			{
				"<leader>rc",
				function()
					require("refactoring").debug.cleanup({})
				end,
				desc = "Debug Cleanup",
			},
			{
				"<leader>rf",
				function()
					require("refactoring").refactor("Extract Function")
				end,
				mode = "v",
				desc = "Extract Function",
			},
			{
				"<leader>rF",
				function()
					require("refactoring").refactor("Extract Function To File")
				end,
				mode = "v",
				desc = "Extract Function To File",
			},
			{
				"<leader>rx",
				function()
					require("refactoring").refactor("Extract Variable")
				end,
				mode = "v",
				desc = "Extract Variable",
			},
			{
				"<leader>rp",
				function()
					require("refactoring").debug.print_var()
				end,
				mode = "v",
				desc = "Debug Print Variable",
			},
		},
		opts = {
			prompt_func_return_type = {
				go = false,
				java = false,
				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			prompt_func_param_type = {
				go = false,
				java = false,
				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			printf_statements = {},
			print_var_statements = {},
			show_success_message = true, -- shows a message with information about the refactor on success
			-- i.e. [Refactor] Inlined 3 variable occurrences
		},
		config = function(_, opts)
			require("refactoring").setup(opts)
		end,
	},
}
