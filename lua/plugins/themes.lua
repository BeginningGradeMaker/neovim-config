return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            background = {
                light = "frappe",
                dark = "mocha",
            },
            term_colors = true,
            integrations = {
                telescope = {
                    enabled = true,
                    -- style = "nvchad",
                },
                blink_cmp = true,
                grug_far = true,
                noice = true,
                notify = true,
                snacks = true,
                lsp_trouble = true,
                which_key = true,
                dropbar = {
                    enabled = true,
                    color_mode = true, -- enable color for kind's texts, not just kind's icons
                },
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
        end,
    },
    {
        "olimorris/onedarkpro.nvim",
        optional = not vim.g.opt_themes,
        enabled = vim.g.opt_themes,
        priority = 1000, -- ensure it loads first
        -- config = function()
        -- 	-- somewhere in your config:
        -- end,
    },
    {
        "luisiacc/the-matrix.nvim",
        optional = not vim.g.opt_themes,
        enabled = vim.g.opt_themes,
        priority = 1000,
    },
    {
        "diegoulloao/neofusion.nvim",
        optional = not vim.g.opt_themes,
        enabled = vim.g.opt_themes,
        priority = 1000,
        config = true,
    },
    {
        "folke/tokyonight.nvim",
        optional = not vim.g.opt_themes,
        enabled = vim.g.opt_themes,
        priority = 1000,
        opts = {
            transparent = false,
            styles = {
                sidebars = "transparent",
                -- floats = "transparent",
            },
            sections = {},
        },
    },
    {
        "projekt0n/github-nvim-theme",
        enabled = vim.g.opt_themes,
        optional = not vim.g.opt_themes,
        priority = 1000,
    },
    {
        "sainnhe/gruvbox-material",
        -- optional = not vim.g.opt_theme,
        enabled = vim.g.opt_themes,
        priority = 1000,
    },
    {
        "scottmckendry/cyberdream.nvim",
        optional = not vim.g.opt_themes,
        enabled = vim.g.opt_themes,
        lazy = false,
        priority = 1000,
        config = function()
            local cyberdream = require("cyberdream")
            cyberdream.setup()

            -- Add a custom keybinding to toggle the colorscheme
            vim.api.nvim_set_keymap("n", "<leader>tm", ":CyberdreamToggleMode<CR>", { noremap = true, silent = true })
            -- The event data property will contain a string with either "default" or "light" respectively
            vim.api.nvim_create_autocmd("User", {
                pattern = "CyberdreamToggleMode",
                callback = function(event)
                    -- Your custom code here!
                    -- For example, notify the user that the colorscheme has been toggled
                    print("Switched to " .. event.data .. " mode!")
                end,
            })
        end,
    },
    {
        "rose-pine/neovim",
        optional = not vim.g.opt_theme,
        enabled = vim.g.opt_themes,
        lazy = false,
        priority = 1000,
        name = "rose-pine",
    },
    {
        "shaunsingh/nord.nvim",
        optional = not vim.g.opt_theme,
        enabled = vim.g.opt_themes,
        priority = 1000,
    },
    {
        "rebelot/kanagawa.nvim",
        optional = false,
        enabled = true,
        priority = 1000,
    },
    {
        "Mofiqul/vscode.nvim",
        optional = not vim.g.opt_theme,
        enabled = vim.g.opt_themes,
        priority = 1000,
    },
    {
        "loctvl842/monokai-pro.nvim",
        optional = not vim.g.opt_theme,
        enabled = vim.g.opt_themes,
        priority = 1000,
    },
    {
        "marko-cerovac/material.nvim",
        priority = 1000,
    },
    {
        "bluz71/vim-moonfly-colors",
        priority = 1000,
    },
    {
        "armannikoyan/rusty",
        lazy = false,
        opts = {
            transparent = false,
            italic_comments = true,
            underline_current_line = true,
        },
        config = function(_, opts)
            require("rusty").setup(opts)
        end,
        priority = 1000,
    },
}
