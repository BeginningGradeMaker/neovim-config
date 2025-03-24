return {
	{
		"yetone/avante.nvim",
        enabled = false,
        cmd = {"AvanteAsk", "AvanteBuild", "AvanteChat", "AvanteEdit", "AvanteFocus", "AvanteRefresh", "AvanteSwitchProvider", "AvanteShowRepoMap", "AvanteToggle"},
		opts = {
			-- add any opts here
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante", "snacks_notif_history" },
				},
				ft = { "markdown", "Avante", "snacks_notif_history" },
			},
		},
	},
}
