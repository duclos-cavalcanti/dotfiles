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

-- KEY MAPPINGS
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Terminal
tnoremap("<ESC>", "<C-\\><C-n>")
tnoremap("<C-w>", "<C-\\><C-N><C-w>")
nnoremap("<leader><space>", ":split <BAR> :resize 20 <BAR> term<CR>i")

-- Telescope
nnoremap("<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<CR>")
nnoremap("<leader>sF", "<cmd>lua require('telescope.builtin').find_files({cwd=vim.fn.input('Breakpoint condition: ')})<CR>")
nnoremap("<leader>sH", "<cmd>lua require('telescope.builtin').find_files({cwd='~'})<CR>")

nnoremap("<leader>sb", "<cmd>lua require('telescope.builtin').buffers()<CR>")
nnoremap("<leader>sl", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
nnoremap("<leader>sr", "<cmd>lua require('telescope.builtin').live_grep()<CR>")

nnoremap("<leader>lh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
nnoremap("<leader>lm", "<cmd>lua require('telescope.builtin').man_pages()<CR>")
nnoremap("<leader>ld", "<cmd>lua require('telescope').extensions.dap.commands{}<CR>")
nnoremap("<leader>lb", "<cmd>lua require('telescope').extensions.dap.list_breakpoints{}<CR>")
nnoremap("<leader>lv", "<cmd>lua require('telescope').extensions.dap.variables{}<CR>")
nnoremap("<leader>lf", "<cmd>lua require('telescope').extensions.dap.frames{}<CR>")

-- tagbar / symbols ouline
nnoremap("<C-Space>", ":SymbolsOutline<CR>")

-- File explorer
nnoremap("<leader>e", "<Cmd>NvimTreeToggle<CR>")

-- Neogit/Git
nnoremap("<leader>gg", "<cmd>lua require('neogit').open()<CR>")
nnoremap("<leader>gs", "<cmd>lua require('neogit').open({kind = 'split'})<CR>")
nnoremap("<leader>gv", "<cmd>lua require('neogit').open({kind = 'vsplit'})<CR>")

-- Debugger
nnoremap("<leader>dc", "<cmd>lua require'dap'.continue()<CR>")
nnoremap("<leader>dC", "<cmd>lua require'dapui'.close(); require'dap'.close()<CR>")

nnoremap("<leader>ds", "<cmd>lua require'dap'.step_over()<CR>")
nnoremap("<leader>di", "<cmd>lua require'dap'.step_into()<CR>")

nnoremap("<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
nnoremap("<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>'")

nnoremap("<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>")

-- Tabs
nnoremap("<TAB>", ":tabn<CR>")
nnoremap("<S-TAB>", ":tabp<CR>")
nnoremap("<M-1>", ":tabmove -1<CR>")
nnoremap("<M-2>", ":tabmove +1<CR>")

-- Splits resizing
nnoremap("<C-w>>", "10<C-w>>")
nnoremap("<C-w><", "10<C-w><")
nnoremap("<C-w>+", "10<C-w>+")
nnoremap("<C-w>-", "10<C-w>-")

-- Utils
nnoremap("Y", "y$")
nnoremap("vv", "v$h")
nnoremap("z.", "zszH")

-- Buffers
nnoremap("<M-w>", ":bd<CR>")
nnoremap("<C-s>", "<C-^>")

-- Quickfix list
nnoremap("<C-n>", ":cnext<CR>")
nnoremap("<C-p>", ":cprev<CR>")

-- Local list
nnoremap("<M-N>", ":lnext<CR>")
nnoremap("<M-P>", ":lprev<CR>")

-- COMMAND MAPPINGS
vim.cmd("command! Make !make")
vim.cmd("command! ReloadScheme lua require('themes')")
vim.cmd("command! ReloadSnippets lua require('plugins.luasnip').setup()")

-- Remove trailing whitespaces
vim.cmd [[autocmd BufWritePre * %s/\s\+$//e ]]
