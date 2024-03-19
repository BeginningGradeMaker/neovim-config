return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				-- python = { "isort", "black" },
				-- You can customize some of the format options for the filetype (:help conform.format)
				-- rust = { "rustfmt", lsp_format = "fallback" },
				-- Conform will run the first available formatter
				javascript = { "prettierd", "prettier", stop_after_first = true },
			},
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
		})

		vim.keymap.set("n", "<leader>cf", function()
			conform.format({ timeout_ms = 500, lsp_format = "fallback", bufnr = vim.api.nvim_get_current_buf() })
		end, { desc = "Code format" })

		-- vim.api.nvim_create_autocmd("BufWritePre", {
		--   pattern = "*",
		--   callback = function(args)
		--         require("conform").format({ bufnr = args.buf })
		--       end,
		-- })
	end,
}
