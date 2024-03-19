return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
      integrations = {
        telescope = {
          enabled = true,
          style = "nvchad",
        },
      }
    },
    config = function()
      require("catppuccin").setup({})
      -- vim.cmd.colorscheme "catppuccin"
    end
  },
  {
    "AstroNvim/astrotheme",
    config = function()
      require("astrotheme").setup({
        style = {
          transparent = false,    -- Bool value, toggles transparency.
          inactive = true,        -- Bool value, toggles inactive window color.
          float = true,           -- Bool value, toggles floating windows background colors.
          neotree = true,         -- Bool value, toggles neo-trees background color.
          border = true,          -- Bool value, toggles borders.
          title_invert = true,    -- Bool value, swaps text and background colors.
          italic_comments = true, -- Bool value, toggles italic comments.
          -- simple_syntax_colors = true, -- Bool value, simplifies the amounts of colors used for syntax highlighting.
        },
        plugins = { -- Allows for individual plugin overrides using plugin name and value from above.
          ["bufferline.nvim"] = true,
          ["nvim-treesitter"] = true,
          ["dashboard-nvim"] = true,
          ["telescope.nvim"] = true
        },
        integrations = {
          telescope = {
            enabled = true,
            style = "nvchad",
          },
        }
        -- highlights = {
        --   global = { -- Add or modify hl groups globally, theme specific hl groups take priority.
        --     modify_hl_groups = function(hl, c)
        --       hl.PluginColor4 = { fg = c.my_grey, bg = c.none }
        --     end,
        --     ["@String"] = { fg = "#ff00ff", bg = "NONE" },
        --   },
        --   astrodark = {
        --     -- first parameter is the highlight table and the second parameter is the color palette table
        --     modify_hl_groups = function(hl, c) -- modify_hl_groups function allows you to modify hl groups,
        --       hl.Comment.fg = c.my_color
        --       hl.Comment.italic = true
        --     end,
        --     ["@String"] = { fg = "#ff00ff", bg = "NONE" },
        --   },
        -- },
      })
    end
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require 'nordic'.load()
    end
  },
  {
    'navarasu/onedark.nvim',
    lazy = false,
    config = function()
      -- Lua
      require('onedark').setup {
        -- Main options --
        style = 'dark',               -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = false,          -- Show/hide background
        term_colors = true,           -- Change terminal color as per the selected theme style
        ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        toggle_style_key = nil,                                                              -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
        code_style = {
          comments = 'italic',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none'
        },

        -- Lualine options --
        lualine = {
          transparent = false, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {},     -- Override default colors
        highlights = {}, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
          darker = true,     -- darker colors for diagnostic
          undercurl = true,  -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
      }
    end
  },
  {
    'sainnhe/sonokai'
  }
}
-- require("catppuccin").setup()
