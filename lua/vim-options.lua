vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.wo.relativenumber = true

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Standard Operations
vim.keymap.set('n', "<leader>s", "<cmd>s<cr>", { desc = "Save" })
vim.keymap.set('n', "<leader>x", "<cmd>bd<cr>", { desc = "Close current buffer" })
vim.keymap.set('n', "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set('n', "<leader>W", "<cmd>wqa<cr>", { desc = "Save All and quit" })
vim.keymap.set('n', "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit" })
vim.keymap.set('n', "<leader>Q", "<cmd>confirm qall<cr>", { desc = "Quit all" })
vim.keymap.set('n', "<leader>n", "<<cmd>enew<cr>", { desc = "New File" })
vim.keymap.set('n', "<C-s>", "<cmd>w!<cr>", { desc = "Force write" })
vim.keymap.set('n', "<C-q>", "<cmd>qa!<cr>", { desc = "Force quit" })
vim.keymap.set('n', "|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
vim.keymap.set('n', "\\", "<cmd>split<cr>", { desc = "Horizontal Split" })

-- Switch buffers
vim.keymap.set('n', "H", ":bp<cr>", { desc = "Previous buffer" })
vim.keymap.set('n', "L", ":bn<cr>", { desc = "Next buffer" })

-- Vim-tex
vim.g.tex_flavor = 'latex'
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_view_general_viewer = 'zathura'
vim.g.vimtex_compiler_progname = 'nvr'

-- Insert blank lines in normal mode
vim.keymap.set('n', '<S-CR>', 'm`o<Esc>``')
vim.keymap.set('n', '<CR>', 'm`O<Esc>``')
-- vim.keymap.set('n', '<S-CR>', '@="m`o<C-V><Esc>``"<CR>')
-- vim.keymap.set('n', '<CR>', '@="m`O<C-V><Esc>``"<CR>')

-- hijack netrw
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- hide ~ chars at the end of file
vim.opt.fillchars = { eob = " " }

-- Copy all content of buffer
vim.keymap.set('n', '<leader>aa', "<cmd>%y+<cr>", { desc = "Yank entire file" })
vim.keymap.set('n', '<leader>ad', "<cmd>%d<cr>", { desc = "Yank entire file" })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {
        clear = true,
    }),
    callback = function()
        vim.highlight.on_yank()
    end
})
