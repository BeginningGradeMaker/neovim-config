return {
	"stevearc/resession.nvim",
	config = function()
		local resession = require("resession")
		resession.setup({
			autosave = {
				enabled = true,
				interval = 60,
				notify = false,
			},
		})
		-- Resession does NOTHING automagically, so we have to set up some keymaps
		vim.keymap.set("n", "<leader>ss", resession.save, { desc = "Save this session" })
		vim.keymap.set("n", "<leader>sl", function()
			resession.load("last")
		end, { desc = "Load last session" })
		vim.keymap.set("n", "<leader>sf", resession.load, { desc = "Search sessions" })
		vim.keymap.set("n", "<leader>sf", function()
			resession.load(nil, { dir = "dirsession" })
		end, { desc = "Search directory sessions" })
		vim.keymap.set("n", "<leader>sd", resession.delete, { desc = "Delete sessions" })
		vim.keymap.set("n", "<leader>sD", function()
			resession.delete(nil, { dir = "dirsession" })
		end, { desc = "Delete directory sessions" })
		vim.keymap.set("n", "<leader>s.", function()
			resession.load(nil, { dir = "dirsession" })
		end, { desc = "Load current session" })
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				-- Always save a special session named "last"
				resession.save("last")
			end,
		})
		-- vim.api.nvim_create_autocmd("VimEnter", {
		-- 	callback = function()
		-- 		-- Only load the session if nvim was started with no args
		-- 		if vim.fn.argc(-1) == 0 then
		-- 			-- Save these to a different directory, so our manual sessions don't get polluted
		-- 			resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
		-- 		end
		-- 	end,
		-- })
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
			end,
		})
	end,
}
