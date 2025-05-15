return {
    {
        "folke/snacks.nvim",
        opts = {
            picker = {
                enabled = not vim.g.vscode,
                layout = {
                    preset = function()
                        return vim.o.columns >= 120 and "ivy_taller" or "vertical"
                    end,
                },
                formatters = {
                    file = { filename_first = true }
                },
                win = {
                    input = {
                        keys = {
                            ["<c-n>"] = { "history_forward", mode = { "i", "n" } },
                            ["<c-p>"] = { "history_back", mode = { "i", "n" } },
                        }
                    }
                }
            },
        },
        keys = {
            {
                "<leader>/",
                function() Snacks.picker.grep() end,
                desc = "Grep"
            },
            {
                "<leader>:",
                function() Snacks.picker.command_history() end,
                desc = "Command History"
            },
            {
                "<leader><leader>",
                function()
                    Snacks.picker.smart()
                end,
                desc = "Find Files"
            },
            -- find
            {
                "<leader>b",
                function() Snacks.picker.buffers() end,
                desc = "Buffers"
            },
            {
                "<leader>fm",
                function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
                desc = "Find Config File"
            },
            {
                "<leader>gf",
                function() Snacks.picker.git_files() end,
                desc = "Find Git Files"
            },
            {
                "<leader>fR",
                function() Snacks.picker.recent() end,
                desc = "Recent"
            },
            -- git
            {
                "<leader>gc",
                function() Snacks.picker.git_log() end,
                desc = "Git Log"
            },
            {
                "<leader>gs",
                function() Snacks.picker.git_status() end,
                desc = "Git Status"
            },
            -- Grep
            {
                "<leader>fb",
                function() Snacks.picker.lines() end,
                desc = "Buffer Lines"
            },
            {
                "<leader>fB",
                function() Snacks.picker.grep_buffers() end,
                desc = "Grep Open Buffers"
            },
            {
                "<leader>fw",
                function() Snacks.picker.grep() end,
                desc = "Grep"
            },
            {
                "<leader>f.",
                function() Snacks.picker.grep_word() end,
                desc = "Visual selection or word",
                mode = { "n", "x" }
            },
            -- search
            {
                '<leader>f"',
                function() Snacks.picker.registers() end,
                desc = "Registers"
            },
            {
                "<leader>fA",
                function() Snacks.picker.autocmds() end,
                desc = "Autocmds"
            },
            {
                "<leader>fc",
                function() Snacks.picker.command_history() end,
                desc = "Command History"
            },
            {
                "<leader>fC",
                function() Snacks.picker.commands() end,
                desc = "Commands"
            },
            {
                "<leader>fd",
                function() Snacks.picker.diagnostics() end,
                desc = "Diagnostics"
            },
            {
                "<leader>fh",
                function() Snacks.picker.help() end,
                desc = "Help Pages"
            },
            {
                "<leader>fH",
                function() Snacks.picker.highlights() end,
                desc = "Highlights"
            },
            {
                "<leader>fj",
                function() Snacks.picker.jumps() end,
                desc = "Jumps"
            },
            {
                "<leader>fk",
                function() Snacks.picker.keymaps() end,
                desc = "Keymaps"
            },
            {
                "<leader>fl",
                function() Snacks.picker.loclist() end,
                desc = "Location List"
            },
            {
                "<leader>fM",
                function() Snacks.picker.man() end,
                desc = "Man Pages"
            },
            {
                "<leader>m",
                function() Snacks.picker.marks() end,
                desc = "Marks"
            },
            {
                "<leader>l",
                function() Snacks.picker.resume() end,
                desc = "Resume"
            },
            {
                "<leader>fq",
                function() Snacks.picker.qflist() end,
                desc = "Quickfix List"
            },
            {
                "<leader>uT",
                function()
                    Snacks.picker.colorschemes({
                        confirm = function(picker, item)
                            picker:close()
                            if item then
                                picker.preview.state.colorscheme = nil
                                vim.schedule(function()
                                    vim.cmd("colorscheme " .. item.text)
                                    local file = io.open("/Users/zhisu/.config/nvim/lua/colorscheme.lua", "w")
                                    file:write(string.format("vim.cmd(\"colorscheme %s\")", item.text))
                                end)
                            end
                        end,
                    })
                end,
                desc = "Colorschemes"
            },
            {
                "<leader>p",
                function() Snacks.picker.projects() end,
                desc = "Projects"
            },
            -- LSP
            {
                "gd",
                function() Snacks.picker.lsp_definitions() end,
                desc = "Goto Definition"
            },
            {
                "gD",
                function() Snacks.picker.lsp_declarations() end,
                desc = "Goto Declarations"
            },
            {
                "gr",
                function() Snacks.picker.lsp_references() end,
                nowait = true,
                desc = "References"
            },
            {
                "gI",
                function() Snacks.picker.lsp_implementations() end,
                desc = "Goto Implementation"
            },
            {
                "gy",
                function() Snacks.picker.lsp_type_definitions() end,
                desc = "Goto T[y]pe Definition"
            },
            -- {
            --     "<leader>fa",
            --     function() Snacks.picker.lsp_symbols({ layout = { preset = "select_top", preview = "main" } }) end,
            --     desc = "LSP Symbols"
            -- },
            {
                "<leader>fa",
                function() Snacks.picker.lsp_workspace_symbols() end,
                desc = "LSP Symbols"
            },
        },
    },
    {
        "bassamsdata/namu.nvim",
        keys = {
            {
                "<leader>ff",
                function()
                    require("namu.namu_symbols").show()
                end,
                desc = "Jump to LSP symbol",
                silent = true,
            },
        },
        config = function()
            require("namu").setup({
                row_position = "top10",
                -- Enable the modules you want
                namu_symbols = {
                    enable = true,
                    options = {
                        movement = {
                            next = { "<C-j>", "<DOWN>" }, -- Support multiple keys
                            previous = { "<C-k>", "<UP>" }, -- Support multiple keys
                        },
                        window = {
                            auto_size = true,
                            min_width = 100,
                            max_height = 10,
                            padding = 4,
                            border = "rounded",
                            show_footer = true,
                            footer_pos = "right",
                        },
                    }, -- here you can configure namu
                },
            })
        end,
    }
}
