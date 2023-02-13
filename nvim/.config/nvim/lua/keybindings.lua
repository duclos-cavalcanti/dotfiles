-- FUNCTIONS
local function map(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, {silent =  true})
end

local function noremap(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, {noremap = true, silent = true})
end

local function exprnoremap(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, {noremap = true, silent = true, expr = true})
end

local function nmap(lhs, rhs) map('n', lhs, rhs) end
local function xmap(lhs, rhs) map('x', lhs, rhs) end
local function nnoremap(lhs, rhs) noremap('n', lhs, rhs) end
local function vnoremap(lhs, rhs) noremap('v', lhs, rhs) end
local function xnoremap(lhs, rhs) noremap('x', lhs, rhs) end
local function inoremap(lhs, rhs) noremap('i', lhs, rhs) end
local function tnoremap(lhs, rhs) noremap('t', lhs, rhs) end
local function exprnnoremap(lhs, rhs) exprnoremap('n', lhs, rhs) end
local function exprinoremap(lhs, rhs) exprnoremap('i', lhs, rhs) end

-------------------
-- KEY MAPPINGS
-------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Utils
nnoremap("Y", "y$")
nnoremap("vv", "v$h")
nnoremap("z.", "zszH")

-- Terminal
tnoremap("<ESC>", "<C-\\><C-n>")
tnoremap("<C-w>", "<C-\\><C-N><C-w>")

nnoremap("<leader><space>", ":split <BAR> :resize 20 <BAR> term<CR>i")

-- Tabs
nnoremap("<M-j>", ":tabp<CR>")
nnoremap("<M-k>", ":tabn<CR>")
nnoremap("<M-J>", ":tabmove -1<CR>")
nnoremap("<M-K>", ":tabmove +1<CR>")

-- Splits resizing
nnoremap("<C-w>>", "5<C-w>>")
nnoremap("<C-w><", "5<C-w><")
nnoremap("<C-w>+", "5<C-w>+")
nnoremap("<C-w>-", "5<C-w>-")

-- Telescope
nnoremap("<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<CR>")
nnoremap("<leader>sF", "<cmd>lua require('telescope.builtin').find_files({cwd=vim.fn.input('Path: ')})<CR>")

nnoremap("<leader>sb", "<cmd>lua require('telescope.builtin').buffers()<CR>")
nnoremap("<leader>sl", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
nnoremap("<leader>sr", "<cmd>lua require('telescope.builtin').live_grep()<CR>")

nnoremap("<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
nnoremap("<leader>sm", "<cmd>lua require('telescope.builtin').man_pages({sections={'ALL'}})<CR>")

-- File explorer
nnoremap("<leader>e", ":Telescope file_browser path=%:p:h<CR>")
nnoremap("<leader>E", ":Telescope file_browser<CR>")

-- Color Scheme Reload
nnoremap("<leader>r", ":so ~/.config/nvim/lua/themes.lua<CR>")

-- Neogit/Git
nnoremap("<leader>g", ":lua require('neogit').open()<CR>")

-- Debugger
nnoremap("<leader>d", ":lua require('telescope').extensions.dap.commands{}<CR>")

-- tagbar / symbols ouline
nnoremap("<C-Space>", ":SymbolsOutline<CR>")

-------------------
-- COMMAND MAPPINGS
-------------------
vim.cmd("command! Scheme so ~/.config/nvim/lua/themes.lua") -- reload colorscheme
vim.cmd("command! W w")

-------------------
-- AUTOCOMMANDS
-------------------
vim.cmd [[ autocmd BufWritePre * %s/\s\+$//e ]] -- Remove trailing whitespaces
vim.cmd [[ autocmd BufWrite *.snippets lua require('ex.luasnip').setup() ]] -- Auto reload snippets

-- Deleting terminals when being closed
vim.cmd [[ autocmd TermEnter term://* setlocal nohidden ]]
vim.cmd [[ autocmd BufHidden term://* q! ]]
