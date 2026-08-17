local map = vim.keymap.set

local function _open()
    local file = vim.api.nvim_buf_get_name(0)
    if file == "" or vim.fn.filereadable(file) == 0 then
        vim.notify("Markdown Preview: no saved file in this buffer", vim.log.levels.WARN)
        return
    end
    vim.fn.jobstart({ "open", "-a", "Markdown Preview", file }, { detach = true })
end

local function _is_qf_open()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "quickfix" then
            return true
        end
    end
    return false
end

local function _qf_next()
    if _is_qf_open then
        vim.cmd("cnext")
    end
end

local function _qf_prev()
    if _is_qf_open then
        vim.cmd("cprev")
    end
end

local function _search_files()
    MiniPick.builtin.cli(
        { command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!.git" } },
        { source = { name = "Files", cwd = vim.fn.getcwd() } }
    )
end

local function _buffers()
    local wipeout = function() vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {}) end
    MiniPick.builtin.buffers({}, { mappings = { wipeout = { char = "<C-d>", func = wipeout } } })
end

function _terminal()
    local term = vim.g._term or {}
    local api = vim.api

    -- visible
    if term.win and api.nvim_win_is_valid(term.win) then
        api.nvim_win_hide(term.win)
        term.win = nil

    -- hidden
    else
        vim.cmd("botright 30 split")
        -- re-use terminal
        if term.buf and api.nvim_buf_is_valid(term.buf) then
            api.nvim_set_current_buf(term.buf)

        -- launch terminal
        else
            vim.cmd("terminal")
            term.buf = api.nvim_get_current_buf()
        end
        term.win = vim.api.nvim_get_current_win()
        vim.cmd("startinsert")
    end
    vim.g._term = term
end

map("t", "<ESC>", "<C-\\><C-n>", { silent = true })
map("t", "<C-w>", "<C-\\><C-N><C-w>", { silent = true })
map("n", "<C-w>>", ":tabmove +1<CR>", { silent = true })
map("n", "<C-w><lt>", ":tabmove -1<CR>", { silent = true })
map("n", "<leader>e", "<cmd>Lexplore<CR>", { silent = true, desc = "Toggle Netrw" })
map("n", "<leader><space>", _terminal, { silent = true, desc = "Toggle Terminal" })
map("n", "<leader>o", _open, { silent = true, desc = "Open buffer in Markdown Preview.app" })
map("n", "<C-n>", _qf_next, { silent = true, desc = "Next quickfix item" })
map("n", "<C-p>", _qf_prev, { silent = true, desc = "Prev quickfix item" })
map("n", "<leader>gp", function() MiniDiff.toggle_overlay() end, { desc = "Git: toggle hunk overlay" })
map({ "n", "x" }, "<leader>gb", function() MiniGit.show_at_cursor() end, { desc = "Git: blame / show at cursor" })
map("n", "<leader>sf",  _search_files, { desc = "Find files (hidden + ignored)" })
map("n", "<leader>sg", function() MiniPick.builtin.grep_live() end, { desc = "Live grep" })
map("n", "<leader>sg", function() MiniPick.builtin.grep_live() end, { desc = "Live grep" })
map("n", "<leader>sb", _buffers,                         { desc = "Find buffers (<C-d> wipeout)" })
map("n", "<leader>sh", function() MiniPick.builtin.help() end,      { desc = "Help tags" })
map("n", "<leader><Tab>", function() MiniExtra.pickers.lsp({ scope = "document_symbol" }) end, { desc = "LSP symbols (document)" })
map("n", "<leader><S-Tab>", function() MiniExtra.pickers.lsp({ scope = "workspace_symbol" }) end, { desc = "LSP symbols (workspace)" })
map("n", "<C-g>f", "<cmd>AgenticSendFile<CR>",       { desc = "Agentic: send file ref" })
map("n", "<C-g>r", "<cmd>AgenticRegister<CR>",       { desc = "Agentic: register tmux session" })
map("x", "<C-g>i", ":<C-u>AgenticSendSelection<CR>", { desc = "Agentic: send selection ref" })
