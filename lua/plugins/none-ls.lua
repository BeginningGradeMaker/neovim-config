return {
  "nvimtools/none-ls.nvim",
  event = "VeryLazy",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.typstfmt,
      },
    })

    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })
  end,
}
