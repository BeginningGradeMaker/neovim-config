-- local get_icon = require("utils").get_icon

return {
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
	{

		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				char = {
					jump_labels = true,
					label = { exclude = "hjkliardcxKb" },
					-- keys = { "f", "F", ";", "," },
				},
			},
			label = {
				exclude = "xKb",
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
}
