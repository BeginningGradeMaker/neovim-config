return {
	"mfussenegger/nvim-dap",
	lazy = true,
	event = "CmdlineEnter",
	dependencies = {
		-- {
		-- 	"jay-babu/mason-nvim-dap.nvim",
		-- 	dependencies = { "nvim-dap" },
		-- 	cmd = { "DapInstall", "DapUninstall" },
		-- 	opts = { handlers = {} },
		-- },
		"nvim-neotest/nvim-nio",
		{ "rcarriga/nvim-dap-ui", opts = { floating = { border = "rounded" } } },
		"leoluz/nvim-dap-go",
		{
			"rcarriga/cmp-dap",
			event = "InsertEnter",
			dependencies = { "nvim-cmp" },
			config = function()
				require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
					sources = {
						{ name = "dap" },
					},
				})
			end,
		},
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		dapui.setup()
		require("dap-go").setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<F5>", function()
			dap.continue()
		end, { desc = "Continue" })
		vim.keymap.set("n", "<F10>", function()
			dap.step_over()
		end, { desc = "Step over" })
		vim.keymap.set("n", "<F11>", function()
			dap.step_into()
		end, { desc = "Step into" })
		vim.keymap.set("n", "<F12>", function()
			dap.step_out()
		end, { desc = "Step out" })
		vim.keymap.set("n", "<Leader>dt", function()
			dap.toggle_breakpoint()
		end, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<Leader>dB", function()
			dap.set_breakpoint()
		end, { desc = "Set breakpoint" })
		vim.keymap.set("n", "<Leader>dp", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end, { desc = "Set breakpoint msg" })
		vim.keymap.set("n", "<Leader>dr", function()
			dap.repl.open()
		end, { desc = "Open console" })
		vim.keymap.set("n", "<Leader>dl", function()
			dap.run_last()
		end, { desc = "Rerun last adapter" })
		vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
			require("dap.ui.widgets").hover()
		end, { desc = "View expr float" })
		vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
			require("dap.ui.widgets").preview()
		end, { desc = "View expr window" })
		vim.keymap.set("n", "<Leader>df", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.frames)
		end, { desc = "View widgets" })
		vim.keymap.set("n", "<Leader>ds", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		end, { desc = "View current scope" })
	end,
}
