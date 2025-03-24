return {
    {
        "stevearc/overseer.nvim",
        lazy = true,
        cmd = {
            "OverseerOpen",
            "OverseerClose",
            "OverseerToggle",
            "OverseerSaveBundle",
            "OverseerLoadBundle",
            "OverseerDeleteBundle",
            "OverseerRunCmd",
            "OverseerRun",
            "OverseerInfo",
            "OverseerBuild",
            "OverseerQuickAction",
            "OverseerTaskAction",
            "OverseerClearCache",
        },
        opts = {
            dap = false,
            task_list = {
                -- bindings = {
                -- 	["<C-h>"] = false,
                -- 	["<C-j>"] = false,
                -- 	["<C-k>"] = false,
                -- 	["<C-l>"] = false,
                -- },
            },
            form = {
                win_opts = {
                    winblend = 0,
                },
            },
            confirm = {
                win_opts = {
                    winblend = 0,
                },
            },
            task_win = {
                win_opts = {
                    winblend = 0,
                },
            },
        },
        -- stylua: ignore
        keys = {
            { "<leader>ow", "<cmd>OverseerToggle<cr>",      desc = "Task list" },
            { "<leader>oo", "<cmd>OverseerRun<cr>",         desc = "Run task" },
            { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
            { "<leader>oi", "<cmd>OverseerInfo<cr>",        desc = "Overseer Info" },
            { "<leader>ob", "<cmd>OverseerBuild<cr>",       desc = "Task builder" },
            { "<leader>ot", "<cmd>OverseerTaskAction<cr>",  desc = "Task action" },
            { "<leader>oc", "<cmd>OverseerClearCache<cr>",  desc = "Clear cache" },
        },
    },
    {
        "ramilito/kubectl.nvim",
        keys = {
            {
                "<leader>k",
                function() require("kubectl").toggle({tab = true}) end,
                noremap = true,
                silent = true,
            }
        },
        -- opts = {
        --     kubectl_cmd = { cmd = "kubectl", env = {}, args = {"-n trends"}, persist_context_change = false },
        -- },
        config = function(_, opts)
            require("kubectl").setup(opts)
        end,
    },
}
