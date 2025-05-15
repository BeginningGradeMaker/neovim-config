return {
	{
		"yetone/avante.nvim",
        enabled = true,
        cmd = {"AvanteAsk", "AvanteBuild", "AvanteChat", "AvanteEdit", "AvanteFocus", "AvanteRefresh", "AvanteSwitchProvider", "AvanteShowRepoMap", "AvanteToggle"},
		opts = {
			-- add any opts here
            provider = "copilot",
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			{ "zbirenbaum/copilot.lua", opts = true }, -- for providers='copilot'
			-- {
			-- 	-- Make sure to set this up properly if you have lazy=true
			-- 	"MeanderingProgrammer/render-markdown.nvim",
			-- 	opts = {
			-- 		file_types = { "markdown", "Avante", "snacks_notif_history" },
			-- 	},
			-- 	ft = { "markdown", "Avante", "snacks_notif_history" },
			-- },
		},
	},
}
