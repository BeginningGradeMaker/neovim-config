local utils = require("utils")
local get_icon = utils.get_icon

return {
	"folke/which-key.nvim",
    lazy = true,
	event = "VeryLazy",
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		defaults = {
			{ "<leader>g", group = get_icon("Git", 1, true) .. "Git" },
			{ "<leader>f", group = get_icon("Search", 1, true) .. "Find" },
			{ "<leader>t", group = get_icon("Terminal", 1, true) .. "Toggle" },
			{ "<leader>c", group = get_icon("DiagnosticHint", 1, true) .. "Code" },
			{ "<leader>u", group = get_icon("Window", 1, true) .. "UI/UX" },
			-- { "<leader>w", group = get_icon("WordFile", 1, true) .. "Workspace" },
			{ "<leader>S", group = get_icon("Session", 1, true) .. "Session" },
			{ "<leader>d", group = get_icon("Debugger", 1, true) .. "Debug" },
			{ "<leader>a", group = get_icon("Spark", 1, true) .. "AI" },
			-- { "<leader>r", group = get_icon("ActiveLSP", 1, true) .. "Competition" },
			{ "<leader>r", group = get_icon("ActiveLSP", 1, true) .. "Refactor" },
			{ "<leader>h", group = get_icon("Git", 1, true) .. "Git" },
            { "<leader>x", group = get_icon("DiagnosticWarn", 1, true) .. "Diagnostic"},
		},
		-- Defer popup for certain keys
		defer = function(ctx)
			if vim.list_contains({ "d", "y" }, ctx.operator) then
				return true
			end
			return vim.list_contains({ "<C-V>", "v", "V" }, ctx.mode)
		end,

		-- icons = { group = vim.g.icons_enabled and "" or "+", separator = "" },
		icons = { rules = false, group = "", separator = "" },
		disable = { filetypes = { "TelescopePrompt" } },
		preset = "modern",
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add(opts.defaults)
	end,
}
