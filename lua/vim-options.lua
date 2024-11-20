vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.wo.relativenumber = false

local keymap = vim.keymap

vim.keymap.set("n", "<leader>tr", function()
   vim.wo.relativenumber = not vim.wo.relativenumber
end, {desc = "Toggle relative numberline"})

vim.opt.swapfile = false

vim.opt.autoread = true

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
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.opt.termguicolors = true

vim.keymap.set("n", "<C-h>", function()
	vim.cmd("bp")
end, { desc = "Previosu buffer", silent = true })
vim.keymap.set("n", "<C-l>", function()
	vim.cmd("bn")
end, { desc = "Next buffer", silent = true })
vim.keymap.set({ "n", "v" }, "<C-j>", "<C-d>", { desc = "Move half screen down." })
vim.keymap.set({ "n", "v" }, "<C-k>", "<C-u>", { desc = "Move half screen up." })
vim.keymap.set({ "i", "c", "o" }, "<C-j>", "<C-n>", { desc = "Select next item" })
vim.keymap.set({ "i", "c", "o" }, "<C-k>", "<C-p>", { desc = "Select previous item" })

vim.keymap.set("n", "<C-Left>", "<C-w><C-h>", { desc = "Move window left" })
vim.keymap.set("n", "<C-Right>", "<C-w><C-l>", { desc = "Move window right" })
vim.keymap.set("n", "<C-Up>", "<C-w><C-k>", { desc = "Move window up" })
vim.keymap.set("n", "<C-Down>", "<C-w><C-j>", { desc = "Move window down" })
keymap.set("n", "<M-Tab>", "<C-w><C-w>", { desc = "Cycle through splits" })
keymap.set("n", "<C-S-h>", "<C-w><C-h>", { desc = "Go left split" })
keymap.set("n", "<C-S-l>", "<C-w><C-l>", { desc = "Go right split" })
keymap.set("n", "<C-S-k>", "<C-w><C-k>", { desc = "Go up split" })
keymap.set("n", "<C-S-j>", "<C-w><C-j>", { desc = "Go down split" })

-- Standard Operations
vim.keymap.set("n", "<leader>s", "<cmd>w<cr>", { desc = "Save", silent = true })
-- vim.keymap.set('n', "<leader>x", "<cmd>bd<cr>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>w", "<cmd>bd<cr>", { desc = "Close current buffer", silent = true })
vim.keymap.set("n", "<leader>W", "<cmd>wqa<cr>", { desc = "Save All and quit" })
vim.keymap.set("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>confirm qall<cr>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>n", "<<cmd>enew<cr>", { desc = "New File" })
vim.keymap.set("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force write" })
vim.keymap.set("n", "<C-q>", "<cmd>qa!<cr>", { desc = "Force quit" })
vim.keymap.set("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
vim.keymap.set("n", "<leader>\\", "<cmd>split<cr>", { desc = "Horizontal Split" })
vim.keymap.set("v", ">", ">gv", { nowait = true, noremap = true })
vim.keymap.set("v", "<", "<gv", { nowait = true, noremap = true })
vim.keymap.set("v", "<Tab>", ">gv", { nowait = true })
vim.keymap.set("v", "<S-tab>", "<gv", { nowait = true })

-- Switch buffers
vim.keymap.set("n", "-", "<C-6>", { silent = true })

-- Insert blank lines in normal mode
vim.keymap.set("n", "<S-CR>", "m`o<Esc>``")
vim.keymap.set("n", "<CR>", "m`O<Esc>``")

-- hijack netrw
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- hide ~ chars at the end of file
vim.opt.fillchars = { eob = " " }

-- Copy all content of buffer
vim.keymap.set("n", "yaa", "<cmd>%y+<cr>", { desc = "Yank entire file" })
vim.keymap.set("n", "dad", "<cmd>%d<cr>", { desc = "Delete entire file" })
vim.keymap.set("n", "<leader>ab", ":%bd|e#|bd#", { noremap = true, desc = "Clean non-active buffers" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {
		clear = true,
	}),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.g.neovide_cursor_vfx_particle_speed = 100.0
vim.g.vimtex_indent_enabled = 1

-- Delete word backword inclusively
vim.keymap.set("n", "db", "dvb", { desc = "Delete word backword", noremap = true })
vim.keymap.set("n", "cb", "cvb", { desc = "Change word backword", noremap = true })

-- Set U to redo
vim.keymap.set("n", "U", "<C-r>", { noremap = true })

vim.o.background = "dark"

-- Don't skip wrapped lines
keymap.set({"n", "v"}, "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
keymap.set({"n", "v"}, "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keymap.set("n", "0", "g0", { noremap = true, silent = true })
keymap.set("n", "$", "g$", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "o" }, "H", "g^", { desc = "End of line", noremap = true, silent = true })
vim.keymap.set({ "n", "v", "o" }, "L", "g$", { desc = "Start of line", noremap = true, silent = true })

keymap.set("n", "s", "<Nop>", {noremap = true})

-- Make change/delete/select whole word default
-- keymap.set("n", "cw", "ciw", { noremap = true, silent = true, desc = "Change word" })
-- keymap.set("n", "dw", "diw", { noremap = true, silent = true, desc = "Delete word" })
-- keymap.set("n", "vw", "viw", { noremap = true, silent = true, desc = "Select word" })

vim.g.disable_autoformat = true
vim.g.copilot_enabled = 0
vim.opt.showtabline = 2

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3


