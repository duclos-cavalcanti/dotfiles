local vim = vim

-- tmux backend. Scope = a tmux session: find claude panes in the *current*
-- session and send to one (or to the pane :AgenticRegister pinned).
-- Backend interface (shared with agentic.wezterm): noun, current_scope,
-- claude_panes, send.
local M = {}

M.noun = "session"

local function run(cmd, stdin)
    local out = vim.fn.system(cmd, stdin)
    if vim.v.shell_error ~= 0 then return nil end
    return out
end

-- The tmux session nvim is in, or nil if nvim isn't inside tmux.
function M.current_scope()
    if (vim.env.TMUX or "") == "" then return nil end
    local out = run({ "tmux", "display-message", "-p", "#{session_name}" })
    return out and vim.trim(out) or nil
end

-- Claude panes within a session (across its windows). Detection uses tmux's
-- own foreground command (`pane_current_command`), which reads "claude" whether
-- claude is the pane's root process (e.g. launched as `claude --agent X`) or a
-- foreground child of a shell. claude is a TUI, so it holds the foreground even
-- while running tool subprocesses.
function M.claude_panes(session)
    local out = run({
        "tmux", "list-panes", "-s", "-t", session,
        "-F", "#{pane_id}\t#{pane_current_command}\t#{window_name}\t#{pane_current_path}",
    })
    if not out then return {} end

    local targets = {}
    for line in out:gmatch("[^\n]+") do
        local pane, cmd, win, cwd = line:match("([^\t]+)\t([^\t]*)\t([^\t]*)\t(.+)")
        if pane and cmd == "claude" then
            local name = (win and win ~= "" and win) or vim.fn.fnamemodify(cwd, ":~")
            table.insert(targets, {
                id = pane,
                pane = pane,
                scope = session,
                label = string.format("%s  (%s)", name, pane),
            })
        end
    end
    return targets
end

function M.send(target, text, press_enter)
    local pane = target.pane
    local buffer = "agentic-" .. pane
    if not run({ "tmux", "load-buffer", "-b", buffer, "-" }, text) then return end
    if not run({ "tmux", "paste-buffer", "-b", buffer, "-d", "-r", "-t", pane }) then return end
    if press_enter then
        run({ "tmux", "send-keys", "-t", pane, "Enter" })
    end
    run({ "tmux", "select-pane", "-t", pane })
end

return M
