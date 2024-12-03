return {
	"nvim-neo-tree/neo-tree.nvim",
	lazy = true,
    enabled = true,
	cmd = "Neotree",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	keys = {
		-- {
		-- 	"<leader>E",
		-- 	function()
		-- 		require("neo-tree.command").execute({ toggle = true, dir = vim.fn.expand("%:p:h") })
		-- 	end,
		-- 	desc = "Toggle explorer (cb)",
		-- 	remap = true,
		-- },
		{
			"<leader>ue",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
			end,
			desc = "Toggle explorer (cwd)",
			remap = true,
		},
		{
			"<leader>ge",
			function()
				require("neo-tree.command").execute({ source = "git_status", toggle = true })
			end,
			desc = "Git explorer",
		},
		-- {
		--   "<leader>bb",
		--   function()
		--     require("neo-tree.command").execute({ source = "buffers", toggle = true })
		--   end,
		--   desc = "Buffer explorer",
		-- },
	},
	config = function()
		local utils = require("utils")
		local get_icon = utils.get_icon
		require("neo-tree").setup({
			close_if_last_window = true,
			auto_clean_after_session_restore = true,
			sources = { "filesystem", "buffers", "git_status" },
			source_selector = {
				winbar = false,
				content_layout = "center",
				sources = {
					{ source = "filesystem", display_name = get_icon("FolderClosed", 1, true) .. "File" },
					{ source = "buffers", display_name = get_icon("DefaultFile", 1, true) .. "Bufs" },
					{ source = "git_status", display_name = get_icon("Git", 1, true) .. "Git" },
					{ source = "diagnostics", display_name = get_icon("Diagnostic", 1, true) .. "Diagnostic" },
				},
			},
			default_component_configs = {
				indent = { padding = 0 },
				icon = {
					folder_closed = get_icon("FolderClosed"),
					folder_open = get_icon("FolderOpen"),
					folder_empty = get_icon("FolderEmpty"),
					folder_empty_open = get_icon("FolderEmpty"),
					default = get_icon("DefaultFile"),
				},
				modified = { symbol = get_icon("FileModified") },
				git_status = {
					symbols = {
						added = get_icon("GitAdd"),
						deleted = get_icon("GitDelete"),
						modified = get_icon("GitChange"),
						renamed = get_icon("GitRenamed"),
						untracked = get_icon("GitUntracked"),
						ignored = get_icon("GitIgnored"),
						unstaged = get_icon("GitUnstaged"),
						staged = get_icon("GitStaged"),
						conflict = get_icon("GitConflict"),
					},
				},
			},
			commands = {
				parent_or_close = function(state)
					local node = state.tree:get_node()
					if (node.type == "directory" or node:has_children()) and node:is_expanded() then
						state.commands.toggle_node(state)
					else
						require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					end
				end,
				child_or_open = function(state)
					local node = state.tree:get_node()
					if node.type == "directory" or node:has_children() then
						if not node:is_expanded() then -- if unexpanded, expand
							state.commands.toggle_node(state)
						else -- if expanded and has children, seleect the next child
							require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
						end
					else -- if not a directory just open it
						state.commands.open(state)
					end
				end,
				copy_selector = function(state)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local filename = node.name
					local modify = vim.fn.fnamemodify

					local vals = {
						["BASENAME"] = modify(filename, ":r"),
						["EXTENSION"] = modify(filename, ":e"),
						["FILENAME"] = filename,
						["PATH (CWD)"] = modify(filepath, ":."),
						["PATH (HOME)"] = modify(filepath, ":~"),
						["PATH"] = filepath,
						["URI"] = vim.uri_from_fname(filepath),
					}

					local options = vim.tbl_filter(function(val)
						return vals[val] ~= ""
					end, vim.tbl_keys(vals))
					if vim.tbl_isempty(options) then
						return
					end
					table.sort(options)
					vim.ui.select(options, {
						prompt = "Choose to copy to clipboard:",
						format_item = function(item)
							return ("%s: %s"):format(item, vals[item])
						end,
					}, function(choice)
						local result = vals[choice]
						if result then
							utils.notify(("Copied: `%s`"):format(result))
							vim.fn.setreg("+", result)
						end
					end)
				end,
				find_in_dir = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					require("telescope.builtin").find_files({
						cwd = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h"),
					})
				end,
			},
			window = {
				position = "left",
				width = 40,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["<space>"] = "none",
					["Y"] = {
						function(state)
							local node = state.tree:get_node()
							local path = node:get_id()
							vim.fn.setreg("+", path, "c")
						end,
						desc = "copy path to clipboard",
					},
					["[b"] = "prev_source",
					["]b"] = "next_source",
					F = require("utils").is_available("telescope.nvim") and "find_in_dir" or nil,
					h = "parent_or_close",
					l = "child_or_open",
					o = "open",
				},
				fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
					["<C-j>"] = "move_cursor_down",
					["<C-k>"] = "move_cursor_up",
				},
			},
			filesystem = {
				follow_current_file = { enabled = true },
				hijack_netrw_behavior = "open_current",
				use_libuv_file_watcher = vim.fn.has("win32") ~= 1,
			},
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function(_)
						vim.opt_local.signcolumn = "auto"
					end,
				},
			},
		})
	end,
}
