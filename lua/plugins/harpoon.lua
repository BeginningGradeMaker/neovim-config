return {
	{
		"ThePrimeagen/harpoon",
		lazy = true,
		event = "VeryLazy",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"letieu/harpoon-lualine",
				dependencies = {
					{
						"ThePrimeagen/harpoon",
						branch = "harpoon2",
					},
				},
			},
		},
		config = function()
			local harpoon = require("harpoon")
			-- REQUIRED
			harpoon.setup({})
			-- REQUIRED

			vim.keymap.set("n", "<leader>m", function()
				harpoon:list():add()
			end, { desc = "Add file to carpoon list" })
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<C-1>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<C-2>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<C-3>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<C-4>", function()
				harpoon:list():select(4)
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-p>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<C-n>", function()
				harpoon:list():next()
			end)
		end,
	},
}