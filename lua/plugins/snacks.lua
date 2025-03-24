return {
    "folke/snacks.nvim",
    lazy = false,
    cmd = "Snacks",
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
        styles = {
            notification_history = {
                backdrop = 100,
            },
        },
        bigfile = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        scratch = {
            enabled = true,
        },
        explorer = {
            enabled = true,
            replace_netrw = true
        },
        image = {
            enabeld = true,
        },
        rename = {
            enabled = true,
        },
        scope = {
            enabled = true,
        },
        indent = {
            enabled = true,
            animate = { enabled = false, },
        },
        animate = {
            enabled = true,
        }
    },
    keys = {
        {
            "<leader>w",
            function()
                Snacks.bufdelete()
            end,
            desc = "Close buffer",
        },
        {
            "<leader>gg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
        {
            "<leader>gb",
            function()
                Snacks.git.blame_line()
            end,
            desc = "Git Blame Line",
        },
        {
            "<leader>gB",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Git Browse",
        },
        {
            "<leader>gf",
            function()
                Snacks.lazygit.log_file()
            end,
            desc = "Lazygit Current File History",
        },
        {
            "<leader>gl",
            function()
                Snacks.lazygit.log()
            end,
            desc = "Lazygit Log (cwd)",
        },
        {
            "<leader>cR",
            function()
                Snacks.rename.rename_file()
            end,
            desc = "Rename File",
        },
        {
            "<c-/>",
            function()
                Snacks.terminal.toggle()
            end,
            desc = "Toggle Terminal",
        },
        {
            "<c-_>",
            function()
                Snacks.terminal()
            end,
            desc = "which_key_ignore",
        },
        {
            "]r",
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = "Next Reference",
        },
        {
            "[r",
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = "Prev Reference",
        },
        {
            "<C-.>",
            function()
                Snacks.scratch({ ft = "markdown" })
            end,
            desc = "Toggle Scratch Buffer",
        },
        {
            "<leader>fS",
            function()
                Snacks.scratch.select()
            end,
            desc = "Select Scratch Buffer",
        },
        {
            "<leader>h",
            function()
                Snacks.notifier.show_history()
            end,
            desc = "Notifier history"
        },
        -- explorer
        {
            "<leader>e",
            function()
                Snacks.explorer()
            end,
            desc = "Explorer"
        }
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle
                    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uh")
                Snacks.toggle
                    .option("background", { off = "light", on = "dark", name = "Dark Background" })
                    :map("<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>ui")
                local layouts = require("snacks.picker.config.layouts")
                layouts.ivy_taller = vim.tbl_deep_extend("keep", { layout = { height = 0.6 } }, layouts.ivy)
                layouts.ivy_taller.layout[2][2].width = 0.5
                layouts.select_top = vim.tbl_deep_extend("keep", { layout = { row = 1 } }, layouts.select)
            end,
        })
        vim.g.toggle = require("snacks.toggle")
    end,
}
