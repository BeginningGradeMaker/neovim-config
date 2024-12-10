return {
	{
		"otavioschwanck/arrow.nvim",
		enabled = true,
		lazy = true,
		event = "VeryLazy",
		keys = {
			{ "[m", "<cmd>Arrow prev_buffer_bookmark<cr>", desc = "Goto previous buffer bookmark" },
			{ "]m", "<cmd>Arrow next_buffer_bookmark<cr>", desc = "Goto next buffer bookmark" },
		},
		opts = {
			show_icons = true,
			leader_key = "'", -- Recommended to be a single key
			index_keys = "1234qweradfzxcv56789bnmZXVBNM,ghjklAFGHJKLtyuiopWRTYUIOP", -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
			buffer_leader_key = ",", -- Per Buffer Mappings
			mappings = {
				edit = "E",
				delete_mode = "d",
				clear_all_items = "C",
				toggle = "s", -- used as save if separate_save_and_remove is true
				open_vertical = "|",
				open_horizontal = "-",
				quit = "Esc",
				remove = "x", -- only used if separate_save_and_remove is true
				next_item = "]",
				prev_item = "[",
			},
		},
	},
}
