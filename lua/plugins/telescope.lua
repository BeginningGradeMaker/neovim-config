return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    tag = '0.1.6',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
    },
    config = function()
      local actions = require "telescope.actions"
      local get_icon = require("utils").get_icon
      require('telescope').setup {
        pickers = { colorscheme = { enable_preview = true } },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        defaults = {
          git_worktrees = vim.g.git_worktrees,
          prompt_prefix = get_icon("Selected", 1, true),
          selection_caret = get_icon("Selected", 1, true),
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "bottom", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = { q = actions.close },
          },
          file_ignore_patterns = {"compile_commands.json", "lazy-lock.json"}
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = "Find live grep" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymaps' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = 'Find select telescope' })
      vim.keymap.set('n', '<leader>fc', builtin.grep_string, { desc = 'Find current word' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find diagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Resume last search' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Find recent files ("." for repeat)' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find existing buffers' })
      vim.keymap.set('n', '<leader>fm', function() return builtin.lsp_document_symbols({ symbols = 'function' }) end,
        { desc = 'Find methods' })
      vim.keymap.set('n', '<leader>ut', builtin.colorscheme,
        { desc = 'Change colorscheme' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>f/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = true,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Find NeoVim files' })
    end
  },
}
