return {
  -- {
  --   "kaarmu/typst.vim",
  --   ft = "typst",
  --   lazy = false,
  --   config = function()
  --     vim.g.typst_conceal = 1
  --     vim.keymap.set("n", "<leader>tt", ":Toggle")
  --   end,
  -- },
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "0.3.*",
    keys = {
      {
        "<leader>tt",
        ":TypstPreviewToggle<cr>",
        desc = "Typst preview",
      },
      {
        "<leader>tf",
        ":TypstPreviewFollowCursorToggle<cr>",
        desc = "Typst cursor follow",
      },
    },
    build = function()
      require("typst-preview").update()
    end,
  },
}
