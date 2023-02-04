--[[
Servers:
sudo pacman -S rustup
rustup update stable
rustup component add rls rust-analysis rust-src
RLS is slow, use rust analyzer on nightly!

rust-analyzer
cd .local/bin
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer

nightly with rustfmt
rustup toolchain install nightly
rustup component add rls rust-analysis rust-src --toolchain nightly
rustup override set nightly

sudo pacman -S npm
sudo npm i -g bash-language-server

sudo pacman -S go
go install golang.org/x/tools/gopls@latest

sudo pacman -S clang

sudo pacman -S haskell-language-server

pip install pyright

sudo pacman -S lua-language-server

sudo pacman -S gradle jdk-openjdk
paru -S jdtls

--]]

local function _on_attach(client, bufnr)
  -- Set omnifunc
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Helper function
    local opts = {noremap = true, silent = false}
    local function bufnnoremap(lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, opts)
    end

    bufnnoremap("gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
    bufnnoremap("gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
    bufnnoremap("gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>")
    bufnnoremap("gr", "<cmd>Telescope lsp_references<CR>")  -- Uses Telescope
    bufnnoremap("K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
    bufnnoremap("<gh>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")
    bufnnoremap("<leader>R", "<Cmd>lua vim.lsp.buf.rename()<CR>")
    bufnnoremap("<C-n>", "<Cmd>lua vim.diagnostic.goto_next()<CR>")
    bufnnoremap("<C-p>", "<Cmd>lua vim.diagnostic.goto_prev()<CR>")
end

-- add capabilities from nvim-cmp
local _capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require('lspconfig').clangd.setup({
    on_attach = _on_attach,
    capabilities = _capabilities,
    cmd = { "clangd" },
    filetypes = { "c", "cpp" },
})

require('lspconfig').gopls.setup({
    on_attach = _on_attach,
    capabilities = _capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gotmpl" },
})

require('lspconfig').rls.setup {
  settings = {
    rust = {
      unstable_features = true,
      build_on_save = false,
      all_features = true,
    },
  },
}
require('lspconfig').pyright.setup({
    on_attach = _on_attach,
    capabilities = _capabilities,
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
})

require('lspconfig').ghdl_ls.setup({
    on_attach = _on_attach,
    capabilities = _capabilities,
    cmd = { "ghdl-ls" },
    filetypes = { "vhdl" },
})

require('lspconfig').hls.setup({
    on_attach = _on_attach,
    capabilities = _capabilities,
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    filetypes = { "haskell", "lhaskell" },
})

require('lspconfig').bashls.setup({
    on_attach = _on_attach,
    capabilities = _capabilities,
    cmd = { "bash-language-server", "start" },
    cmd_env = {
      GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)"
    },
    filetypes = { "sh", "bash" },
    -- root_dir = util.find_git_ancestor,
    single_file_support = true,
})

require('lspconfig').sumneko_lua.setup({
    on_attach = _on_attach,
    capabilities = _capabilities,
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        runtime = {
            -- version = 'LuaJIT',
            version = 'Lua 5.4',
            path = runtime_path
        },
        diagnostics = {
            globals = {
                       "vim",
                       "awesome",
                       "client",
                       "screen",
                       "client",
                       "window",
                       "tag",
                       "root"
                   },
        },
        workspace = {
            library = {
                vim.api.nvim_get_runtime_file("", true),
                "/usr/share/awesome/lib",
            }
        },
        telemetry = {
            enable = false
        },
    },
    single_file_support = true,
})