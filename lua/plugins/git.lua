local get_icon = require("utils").get_icon
return {
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		lazy = false,
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = get_icon("GitSign") },
					change = { text = get_icon("GitSign") },
					delete = { text = get_icon("GitSign") },
					topdelete = { text = get_icon("GitSign") },
					changedelete = { text = get_icon("GitSign") },
					untracked = { text = get_icon("GitSign") },
				},
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, {desc = "Next hunk"})

					map("n", "[h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, {desc = "Prev hunk"})

					-- Actions
					-- map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
					-- map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Rest hunk" })
					map("v", "<leader>gs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Stage hunk" })
					map("v", "<leader>gr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Reset hunk" })
					map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
					map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
					map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset stage hunk" })
					map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
					-- map("n", "<leader>hb", function()
					-- 	gitsigns.blame_line({ full = true })
					-- end, { desc = "Blame line" })
					map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Git blame line" })
                    map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff this" })
					map("n", "<leader>gD", function()
						gitsigns.diffthis("~")
					end, {desc = "Diff this ~"})
					map("n", "<leader>td", gitsigns.toggle_deleted, {desc = "Git deleted"})

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git select hunk" })
				end,
			})
		end,
	},
    -- Replace this with snack.nvim
	-- {
	-- 	"kdheepak/lazygit.nvim",
	-- 	lazy = true,
	-- 	event = "VeryLazy",
	-- 	-- optional for floating window border decoration
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	config = function()
	-- 		-- nvim v0.8.0
	-- 		-- require("lazygit").setup()
	-- 		vim.keymap.set("n", "<leader>gp", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
	-- 	end,
	-- },
}
