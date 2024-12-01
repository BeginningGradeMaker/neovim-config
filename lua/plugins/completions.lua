return {
	-- {
	-- 	"saghen/blink.cmp",
	-- 	opts_extend = {
	-- 		"sources.completion.enabled_providers",
	-- 		"sources.compat",
	-- 	},
	-- 	dependencies = {
	-- 		"rafamadriz/friendly-snippets",
	-- 		-- add blink.compat to dependencies
	-- 		{
	-- 			"saghen/blink.compat",
	-- 			optional = true, -- make optional so it's only enabled if any extras need it
	-- 			opts = {},
	-- 		},
	-- 	},
	-- 	event = "InsertEnter",
	--
	-- 	---@module 'blink.cmp'
	-- 	---@type blink.cmp.Config
	-- 	opts = {
	-- 		highlight = {
	-- 			-- sets the fallback highlight groups to nvim-cmp's highlight groups
	-- 			-- useful for when your theme doesn't support blink.cmp
	-- 			-- will be removed in a future release, assuming themes add support
	-- 			use_nvim_cmp_as_default = false,
	-- 		},
	-- 		-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
	-- 		-- adjusts spacing to ensure icons are aligned
	-- 		nerd_font_variant = "mono",
	-- 		completion = {
	-- 			menu = {
	-- 				winblend = vim.o.pumblend,
	-- 			},
	-- 			documentation = {
	-- 				auto_show = true,
	-- 				auto_show_delay_ms = 200,
	-- 			},
	-- 			ghost_text = {
	-- 				enabled = vim.g.ai_cmp,
	-- 			},
	-- 		},
	--
	-- 		-- experimental auto-brackets support
	-- 		accept = { auto_brackets = { enabled = true } },
	--
	-- 		-- experimental signature help support
	-- 		-- trigger = { signature_help = { enabled = true } }
	-- 		sources = {
	-- 			-- adding any nvim-cmp sources here will enable them
	-- 			-- with blink.compat
	-- 			compat = {},
	-- 			completion = {
	-- 				-- remember to enable your providers here
	-- 				enabled_providers = { "lsp", "path", "snippets", "buffer" },
	-- 			},
	-- 		},
	--
	-- 		keymap = {
	-- 			preset = "super-tab",
	-- 		},
	-- 	},
	-- 	---@param opts blink.cmp.Config | { sources: { compat: string[] } }
	-- 	config = function(_, opts)
	-- 		-- setup compat sources
	-- 		local enabled = opts.sources.completion.enabled_providers
	-- 		for _, source in ipairs(opts.sources.compat or {}) do
	-- 			opts.sources.providers[source] = vim.tbl_deep_extend(
	-- 				"force",
	-- 				{ name = source, module = "blink.compat.source" },
	-- 				opts.sources.providers[source] or {}
	-- 			)
	-- 			if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
	-- 				table.insert(enabled, source)
	-- 			end
	-- 		end
	-- 		require("blink.cmp").setup(opts)
	-- 	end,
	-- },
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
	       lazy = true,
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets
					-- This step is not supported in many windows environments
					-- Remove the below condition to re-enable on windows
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",

			-- If you want to add a bunch of pre-configured snippets,
			--    you can use this plugin to help you. It even has snippets
			--    for various frameworks/libraries/etc. but you will have to
			--    set up the ones that are useful for you.
			'rafamadriz/friendly-snippets',
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local compare = require("cmp.config.compare")
			local luasnip = require("luasnip")
			local border = {
				{ "┌", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "┐", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "┘", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "└", "FloatBorder" },
				{ "│", "FloatBorder" },
			}
			luasnip.config.setup({ update_events = "TextChanged,TextChangedI", border = border })

			-- load snippets from path/of/your/nvim/config/my-cool-snippets
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
			require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/snippets" } })

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
	               view = {
	                   docs = { auto_open = false }
	               },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-j>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
					-- Select the [p]revious item
					["<C-k>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					-- ["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<C-c>"] = cmp.mapping.confirm({ select = true }),
					["<C-o>"] = cmp.mapping.confirm({ select = true }),
					["<C-n>"] = cmp.mapping.close(),
					-- [";"] = cmp.mapping.close(),
					["<Tab>"] = cmp.mapping(function()
						if cmp.visible() then
							local CTRLg_u = vim.api.nvim_replace_termcodes('<C-g>u', true, true, true)
							vim.api.nvim_feedkeys(CTRLg_u, 'n', true)
							cmp.confirm({
								behavior = cmp.ConfirmBehavior.Insert,
								select = true,
							})
						-- elseif vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
						-- 	luasnip.expand_or_jump()
						else
						    require("neotab").tabout()
						end
					end),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				window = {
					-- completion = {
					-- 	border = border,
					-- },
					-- documentation = {
					-- 	-- border = "rounded",
					-- },
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				matching = {
					disallow_fuzzy_matching = true,
					disallow_fullfuzzy_matching = true,
					disallow_partial_fuzzy_matching = false,
					disallow_partial_matching = false,
					disallow_prefix_unmatching = true,
				},
				sources = {
					{ name = "luasnip", keyword_length = 1, max_item_count = 5 },
					{
						name = "nvim_lsp",
						keyword_length = 2,
						max_item_count = 10,
						-- entry_filter = function(entry)
						-- 	return require("cmp").lsp.CompletionItemKind.Function ~= entry:get_kind()
						-- end,
					},
					-- { name = 'path',    max_item_count = 2 },
				},
				sorting = {
					priority_weight = 1.0,
					comparators = {
						compare.offset,
						compare.exact,
						compare.score,
						compare.recently_used,
						compare.locality,
						-- compare.sort_text,
						-- compare.scopes,
						compare.kind,
						compare.sort_text,
						compare.length,
						compare.order,
					},
					performance = {
						max_view_entries = 5,
					},
				},
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				ignored_next_char = "[%w%.]",
				enable_check_bracket_line = true,
                enable_afterquote = true
			})
			local Rule = require("nvim-autopairs.rule")
			local npairs = require("nvim-autopairs")
			-- local cond = require("nvim-autopairs.conds")

			npairs.add_rules({
				Rule("$", "$", { "typ", "typst", "markdown" }),
			})
			npairs.get_rules("`")[1].not_filetypes = { "typ", "typst" }
			-- vim.keymap.set("v", ")", "sa)", { noremap = true, silent = true })
			-- vim.keymap.set("v", '"', 'sa"', { noremap = true, silent = true })
			-- vim.keymap.set("v", "'", "sa'", { noremap = true, silent = true })
			-- vim.keymap.set("v", "$", "sa$", { noremap = true, silent = true })
		end,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
}
