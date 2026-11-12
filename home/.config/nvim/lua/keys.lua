local map = vim.keymap.set

local function _open()
    local file = vim.api.nvim_buf_get_name(0)
    if file == "" or vim.fn.filereadable(file) == 0 then
        vim.notify("Obsidian: no saved file in this buffer", vim.log.levels.WARN)
        return
    end
    -- Hand the file to Obsidian via its URI scheme. Opens only if the file
    -- lives inside a registered vault (e.g. ~/.macfiles, ~/Work/notes).
    local uri = "obsidian://open?path=" .. vim.uri_encode(file)
    vim.fn.jobstart({ "open", uri }, { detach = true })
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
    local wipeout = function()
        local buf = MiniPick.get_picker_matches().current.bufnr
        -- force a terminal, so <C-d> also stops a :Run job
        vim.api.nvim_buf_delete(buf, { force = vim.bo[buf].buftype == "terminal" })
    end
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

-- :Run <cmd> (or <leader>r, which prompts): run a shell command, e.g. `make serve-notes`, in a
-- hidden terminal buffer `run://<cmd>` that keeps running. Find it with <leader>sb; stop it
-- there with <C-d>, or Ctrl-C inside it.
local _runs = {}  -- cmd -> its terminal buffer

local function _run(cmd)
    if not cmd or cmd == "" then return end
    local old = _runs[cmd]
    if old and vim.api.nvim_buf_is_valid(old) then
        if vim.fn.jobwait({ vim.b[old].terminal_job_id }, 0)[1] == -1 then
            vim.notify("run: already running: " .. cmd, vim.log.levels.WARN)
            return
        end
        vim.api.nvim_buf_delete(old, { force = true })
    end

    local buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_call(buf, function()
        vim.fn.jobstart(cmd, {
            term = true,
            on_exit = function(_, code) vim.notify(("run: %s exited (%d)"):format(cmd, code)) end,
        })
    end)
    vim.api.nvim_buf_set_name(buf, "run://" .. cmd)
    _runs[cmd] = buf
    vim.notify("run: " .. cmd)
end

local function _run_prompt()
    vim.ui.input({ prompt = "run: ", completion = "shellcmdline" }, _run)
end

vim.api.nvim_create_user_command("Run", function(opts)
    if opts.args == "" then _run_prompt() else _run(opts.args) end
end, { nargs = "*", complete = "shellcmdline", desc = "Run a command in a hidden terminal" })

map("t", "<ESC>", "<C-\\><C-n>", { silent = true })
map("t", "<C-w>", "<C-\\><C-N><C-w>", { silent = true })
map("n", "<C-w>>", ":tabmove +1<CR>", { silent = true })
map("n", "<C-w><lt>", ":tabmove -1<CR>", { silent = true })
map("n", "<leader>e", "<cmd>Lexplore<CR>", { silent = true, desc = "Toggle Netrw" })
map("n", "<leader><space>", _terminal, { silent = true, desc = "Toggle Terminal" })
map("n", "<leader>r", _run_prompt, { desc = "Run a command in a hidden terminal" })
map("n", "<leader>o", _open, { silent = true, desc = "Open buffer in Obsidian" })
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
