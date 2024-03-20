-- lazy.nvim
return {
    "lervag/vimtex",
    ft = 'tex',
    config = function()
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_quickfix_ignore_filters = { "Underfull", "Overfull", "Missing" }
        vim.g.maplocalleader = ','
    end
}
