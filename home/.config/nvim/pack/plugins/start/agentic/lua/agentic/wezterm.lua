local vim = vim

-- wezterm backend (nvim in a WezTerm pane, outside tmux), via `wezterm cli`.
-- Scope = a WezTerm workspace: find claude panes in the *current* workspace and
-- send to one. :AgenticRegister overrides the workspace.
-- Same interface as agentic.tmux.
local M = {}

M.noun = "workspace"

local function run(cmd, stdin)
    local out = vim.fn.system(cmd, stdin)
    if vim.v.shell_error ~= 0 then return nil end
    return out
end

local function panes()
    local out = run({ "wezterm", "cli", "list", "--format", "json" })
    if not out then return {} end
    local ok, list = pcall(vim.json.decode, out)
    return ok and list or {}
end

-- ttys whose foreground process group runs claude. `wezterm cli list` has no
-- foreground-command field (tmux's pane_current_command), so ask ps: "+" in
-- stat marks the foreground group. claude is a TUI, so it holds the foreground
-- even while running tool subprocesses.
local function claude_ttys()
    local out = run({ "ps", "-A", "-o", "tty=,stat=,comm=" })
    local ttys = {}
    for line in (out or ""):gmatch("[^\n]+") do
        local tty, stat, comm = line:match("^(%S+)%s+(%S+)%s+(.+)$")
        if tty and stat:find("+", 1, true) and vim.fs.basename(comm) == "claude" then
            ttys["/dev/" .. tty] = true
        end
    end
    return ttys
end

-- The workspace nvim's pane is in, or nil if nvim isn't in WezTerm.
function M.current_scope()
    local id = tonumber(vim.env.WEZTERM_PANE or "")
    if not id then return nil end
    for _, p in ipairs(panes()) do
        if p.pane_id == id then return p.workspace end
    end
    return nil
end

-- Claude panes within a workspace (across its windows and tabs).
function M.claude_panes(workspace)
    local ttys = claude_ttys()
    local targets = {}
    for _, p in ipairs(panes()) do
        if p.workspace == workspace and ttys[p.tty_name] then
            local cwd = (p.cwd or ""):gsub("^file://[^/]*", "")
            local name = (p.tab_title ~= "" and p.tab_title) or vim.fn.fnamemodify(cwd, ":~")
            table.insert(targets, {
                id = p.pane_id,
                pane = p.pane_id,
                tab = p.tab_id,
                scope = workspace,
                label = string.format("%s  (pane %d)", name, p.pane_id),
            })
        end
    end
    return targets
end

-- Every workspace (for :AgenticRegister); "*" marks nvim's own.
function M.scopes()
    local current = M.current_scope()
    local counts, order = {}, {}
    for _, p in ipairs(panes()) do
        if not counts[p.workspace] then
            counts[p.workspace] = 0
            table.insert(order, p.workspace)
        end
        counts[p.workspace] = counts[p.workspace] + 1
    end
    local targets = {}
    for _, ws in ipairs(order) do
        table.insert(targets, {
            scope = ws,
            label = string.format("%s%s  (%d panes)", ws, (ws == current) and " *" or "", counts[ws]),
        })
    end
    return targets
end

function M.has_scope(name)
    for _, p in ipairs(panes()) do
        if p.workspace == name then return true end
    end
    return false
end

function M.send(target, text, press_enter)
    local pane = tostring(target.pane)
    if not run({ "wezterm", "cli", "send-text", "--no-paste", "--pane-id", pane }, text) then return end
    if press_enter then
        run({ "wezterm", "cli", "send-text", "--no-paste", "--pane-id", pane }, "\r")
    end
    run({ "wezterm", "cli", "activate-tab", "--tab-id", tostring(target.tab) })
    run({ "wezterm", "cli", "activate-pane", "--pane-id", pane })
end

return M
