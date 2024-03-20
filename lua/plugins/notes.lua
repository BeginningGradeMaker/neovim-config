-- lazy.nvim
return {
    "lervag/vimtex",
    ft = 'tex',
    config = function()
        vim.g.vimtex_view_method = 'skim'
        -- vim.g.vimtex_quickfix_ignore_filters = { "Underfull", "Overfull", "Missing" }
        -- vim.g.maplocalleader = ','
        vim.g.vimtex_quickfix_open_on_warning = 0
    end
}
