local client = vim.lsp.start_client {
    name = "simple_slp",
    cmd = { "/Users/zhisu/Documents/resources/side_projects/simple_lsp/main"},
    -- on_attach = require("zhisu.lsp").on_attach,
}

if not client then
    vim.notify "hey, you didn't do the client thing good"
    return
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.lsp.buf_attach_client(0, client)
    end
})
