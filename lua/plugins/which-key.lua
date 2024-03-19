local utils = require "utils"
local get_icon = utils.get_icon

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    defaults = {
      ["<leader>g"] = { name = get_icon("Bookmarks", 1, true) .. "Goto" },
      ["<leader>f"] = { name = get_icon("Search", 1, true) .. "Find" },
      ["<leader>t"] = { name = get_icon("Terminal", 1, true) .. "Terminal" },
      ["<leader>c"] = { name = get_icon("DiagnosticHint", 1, true) .. "Code" },
      ["<leader>u"] = { name = get_icon("Window", 1, true) .. "UI/UX" },
      ["<leader>w"] = { name = get_icon("WordFile", 1, true) .. "Workspace" },
      ["<leader>S"] = { name = get_icon("Session", 1, true) .. "Session" },
    },
    -- icons = { group = vim.g.icons_enabled and "" or "+", separator = "" },
    icons = { group = "", separator = "" },
    disable = { filetypes = { "TelescopePrompt" } },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end
}
