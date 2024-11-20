return {
	{
		"otavioschwanck/arrow.nvim",
        lazy = true,
        event = "VeryLazy",
        keys = {
            {"[m", "<cmd>Arrow prev_buffer_bookmark<cr>", desc = "Goto previous bookmark"},
            {"]m", "<cmd>Arrow next_buffer_bookmark<cr>", desc = "Goto next bookmark"},
        },
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			-- or if using `mini.icons`
			-- { "echasnovski/mini.icons" },
		},
		opts = {
			show_icons = true,
			leader_key = "'", -- Recommended to be a single key
			buffer_leader_key = "m", -- Per Buffer Mappings
		},
	},
}
