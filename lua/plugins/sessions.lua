return {
	-- Lua
	{
		"folke/persistence.nvim",
		lazy = false,
		-- event = "VeryLazy", -- this will only start session saving when an actual file was opened
		-- opts = {
		-- 	-- add any custom options here
		-- },
		config = function()
			-- load the session for the current directory
			require("persistence").setup({
				need = 1,
			})
			vim.keymap.set("n", "<leader>S.", function()
				require("persistence").load()
			end, { desc = "Load current session" })

			-- select a session to load
			vim.keymap.set("n", "<leader>Ss", function()
				require("persistence").select()
			end, { desc = "Select sessions" })

			-- load the last session
			vim.keymap.set("n", "<leader>Sl", function()
				require("persistence").load({ last = true })
			end, { desc = "Load last session" })

			-- stop Persistence => session won't be saved on exit
			vim.keymap.set("n", "<leader>Sq", function()
				require("persistence").stop()
			end, { desc = "Stop persistence" })
		end,
	},
}
