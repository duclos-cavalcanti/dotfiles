-- Trim trailing whitespace and trailing blank lines on save (Lua files).
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.lua",
    callback = function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[%s/\s\+$//e]])    -- trailing whitespace
        vim.cmd([[%s/\n\+\%$//e]])  -- blank lines at EOF
        pcall(vim.api.nvim_win_set_cursor, 0, cursor)
    end,
    desc = "Trim trailing whitespace and EOF blank lines (Lua)",
})

-- Equalize splits when the terminal window is resized.
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
})

-- Treesitter highlighting per buffer (parsers installed in plugins/core.lua).
vim.api.nvim_create_autocmd("FileType", {
    callback = function() pcall(vim.treesitter.start) end,
    desc = "Start treesitter highlighting",
})

-- LSP buffer-local keymaps on attach (servers enabled in plugins/core.lua).
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP buffer keymaps",
    callback = function(args)
        local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
        end
        map("gd", vim.lsp.buf.definition, "Goto definition")
        map("gD", vim.lsp.buf.declaration, "Goto declaration")
        map("gi", vim.lsp.buf.implementation, "Goto implementation")
        map("gh", vim.lsp.buf.signature_help, "Signature help")
        map("GT", vim.lsp.buf.type_definition, "Goto type definition")
        map("K", vim.lsp.buf.hover, "Hover")
        map("<leader>R", vim.lsp.buf.rename, "Rename")
        map("gn", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
        map("gp", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
        map("gf", vim.diagnostic.open_float, "Diagnostic float")
    end,
})

-- Show diagnostics in a float on hover (pairs with virtual_text=false in
-- config.lua). 'updatetime' controls the delay (also config.lua).
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    desc = "Diagnostics float on hover",
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
    end,
})
