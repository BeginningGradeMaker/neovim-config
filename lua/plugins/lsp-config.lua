local icons = require("icons.nerd_font")
return {
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufReadPost", "BufNewFile", "BufWritePost" },
		dependencies = {
			"williamboman/mason.nvim",
			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },
			{
				"smjonas/inc-rename.nvim",
				config = function()
					require("inc_rename").setup({})
				end,
			},
			"saghen/blink.cmp",
		},
		opts = {
			autoformat = false,
		},
		config = function()
			-- Brief Aside: **What is LSP?**
			--
			-- LSP is an acronym you've probably heard, but might not understand what it is.
			--
			-- LSP stands for Language Server Protocol. It's a protocol that helps editors
			-- and language tooling communicate in a standardized fashion.
			--
			-- In general, you have a "server" which is some tool built to understand a particular
			-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc). These Language Servers
			-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
			-- processes that communicate with some "client" - in this case, Neovim!
			--
			-- LSP provides Neovim with features like:
			--  - Go to definition
			--  - Find references
			--  - Autocompletion
			--  - Symbol Search
			--  - and more!
			--
			-- Thus, Language Servers are external tools that must be installed separately from
			-- Neovim. This is where `mason` and related plugins come into play.
			--
			-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
			-- and elegantly composed help section, `:help lsp-vs-treesitter`

			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself
					-- many times.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("gd", function()
						return require("telescope.builtin").lsp_definitions()
					end, "Goto definition")

					-- Find references for the word under your cursor.
					map("gr", function()
						return require("telescope.builtin").lsp_references()
					end, "Goto references")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", function()
						return require("telescope.builtin").lsp_implementations()
					end, "Goto implementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("gT", function()
						return require("telescope.builtin").lsp_type_definitions()
					end, "Type definition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>fa", function()
						return require("telescope.builtin").lsp_document_symbols()
					end, "Document symbols")

					-- Fuzzy find all the symbols in your current workspace
					--  Similar to document symbols, except searches over your whole project.
					map("<leader>fA", function()
						return require("telescope.builtin").lsp_dynamic_workspace_symbols()
					end, "Workspace symbols")

					-- map("<leader>ti", function()
					-- 	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
					-- end, "Toggle inlay hints")

					-- Rename the variable under your cursor
					--  Most Language Servers support renaming across files, etc.
					-- map("<leader>cn", vim.lsp.buf.rename, "Rename")
					map("<leader>cn", ":IncRename ", "Rename")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "Code action")

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap
					map("K", vim.lsp.buf.hover, "Hover documentation")
					-- map("q", utils.close_floating_windows(), "Hover documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header
					map("gD", vim.lsp.buf.declaration, "Goto declaration")

					map("go", vim.diagnostic.open_float, "Float diagonostics")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end

					if client and client.server_capabilities.codeLensProvider then
						vim.lsp.codelens.refresh({ bufnr = event.buf })
						vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
							buffer = event.buf,
							callback = function()
								vim.lsp.codelens.refresh({ bufnr = event.buf })
							end,
						})
					end

					if client and client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP Specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities = require("blink.cmp").get_lsp_capabilities_capabilities(capabilities)
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.diagnostic.config({
				float = { border = "rounded" },
				-- signs = {
				--     text = {
				--         [vim.diagnostic.severity.ERROR] = icons.DiagnosticError,
				--         [vim.diagnostic.severity.WARN] = icons.DiagnosticWarn,
				--         [vim.diagnostic.severity.HINT] = icons.DiagnosticHint,
				--         [vim.diagnostic.severity.INFO] = icons.DiagnosticInfo,
				--     },
				-- }
			})

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local M = {}
			local servers = {
				-- clangd = {},
				-- gopls = {},
				pyright = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`tsserver`) will work just fine
				-- tsserver = {},
				--
				clangd = {
					on_attach = function(client)
						client.server_capabilities.completionProvider = false
					end,
					cmd = {
						"clangd",
						"--fallback-style=webkit",
						"--offset-encoding=utf-16",
						-- "--clang-tidy",
						"--all-scopes-completion=false",
					},
					handlers = {
						["textDocument/publishDiagnostics"] = function() end,
					},
				},

				lua_ls = {
					capabilities = {
						textDocument = {
							codeLens = {
								dynamicRegistration = false,
							},
						},
					},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
				texlab = {},
				gopls = {},
				tinymist = {
					single_file_support = true,
					root_dir = function()
						return vim.fn.getcwd()
					end,
					settings = {
						-- exportPdf = "onType",
						exportPdf = "onSave",
						-- outputPath = "$root/target/$dir/$name",
					},
				},
			}

			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format lua code
				"pyright",
			})
			for server_name, server in pairs(servers) do
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				require("lspconfig")[server_name].setup(server)
			end
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
		-- ft = "rust",
		keys = {
			{
				"gC",
				function()
					vim.cmd.RustLsp("openCargo")
				end,
				desc = "Open Cargo.toml",
			},
		},
		config = function()
			vim.g.rustaceanvim = {
				-- Plugin configuration
				tools = {},
				-- LSP configuration
				server = {
					-- on_attach = function(client, bufnr)
					-- 	-- you can also put keymaps in here
					-- end,
					default_settings = {
						-- rust-analyzer language server configuration
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
						},
					},
				},
				-- DAP configuration
				dap = {},
			}
		end,
	},
	{
		"scalameta/nvim-metals",
		lazy = true,
		ft = { "scala", "sbt", "java" },
		opts = function()
			local metals_config = require("metals").bare_config()
			metals_config.on_attach = function(client, bufnr)
				-- your on_attach function
			end

			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = self.ft,
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		lazy = true,
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>xs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
				silent = true,
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
				silent = true,
			},
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		optional = true,
		enabled = false,
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup()
		end,
	},
	{ -- LSP Info Dropbar
		"Bekaboo/dropbar.nvim",
		enabled = true,
		lazy = false,
		event = { "BufReadPost", "BufNewFile", "BufWritePost" },
		opts = {
			sources = {
				path = {
					-- Change winbar status when file is modified
					modified = function(sym)
						return sym:merge({
							name = sym.name .. "[+]",
							icon = " ",
							name_hl = "DiffAdded",
							icon_hl = "DiffAdded",
							-- ...
						})
					end,
				},
				lsp = {
					valid_symbols = {
						"File",
						"Module",
						"Namespace",
						"Package",
						"Class",
						"Method",
						"Property",
						"Constructor",
						"Enum",
						"Interface",
						"Function",
						"Constant",
						"Array",
						"Object",
						"EnumMember",
						"Struct",
						"Event",
					},
				},
			},
		},
	},
}
