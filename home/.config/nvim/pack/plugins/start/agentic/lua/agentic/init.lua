local vim = vim

local ref = require("agentic.ref")

-- Backend: wezterm when nvim runs in a WezTerm pane outside tmux; tmux
-- otherwise (also when in neither, so :AgenticRegister can still reach a
-- tmux server).
local function backend()
    if (vim.env.TMUX or "") == "" and (vim.env.WEZTERM_PANE or "") ~= "" then
        return require("agentic.wezterm")
    end
    return require("agentic.tmux")
end

local M = {}

-- A registered scope (tmux session / wezterm workspace) overrides the current
-- one for future sends.
local registered = nil

local function pick(targets, prompt, callback)
    if #targets == 0 then
        vim.notify("agentic: nothing to select", vim.log.levels.WARN)
        return
    end
    if #targets == 1 then
        return callback(targets[1])
    end
    vim.ui.select(targets, {
        prompt = prompt,
        format_item = function(t) return t.label end,
    }, function(choice)
        if choice then callback(choice) end
    end)
end

-- Decide which scope to act in (registered override, else nvim's current
-- one), then pick a claude pane within it.
local function resolve(b, callback)
    local scope = registered
    if scope and not b.has_scope(scope) then
        registered = nil -- registered scope is gone; fall back to current
        scope = nil
    end
    scope = scope or b.current_scope()
    if not scope then
        vim.notify(("agentic: not in a %s (use :AgenticRegister)"):format(b.noun), vim.log.levels.WARN)
        return
    end
    local targets = b.claude_panes(scope)
    if #targets == 0 then
        vim.notify(("agentic: no claude in %s '%s' (try :AgenticRegister)"):format(b.noun, scope), vim.log.levels.WARN)
        return
    end
    pick(targets, "agentic: select claude", callback)
end

function M.send(text, press_enter)
    local b = backend()
    resolve(b, function(t) b.send(t, text, press_enter) end)
end

function M.send_file(press_enter)
    local text = ref.file()
    if text then M.send(text, press_enter) end
end

function M.send_selection(press_enter)
    local text = ref.selection()
    if text then M.send(text, press_enter) end
end

-- Register against ANY scope (tmux: any session on the server, so it works
-- even if nvim isn't in tmux; wezterm: any workspace). Future sends look for
-- claude there. Sticky until re-registered or the scope dies.
function M.register()
    local b = backend()
    pick(b.scopes(), "agentic: register " .. b.noun, function(choice)
        registered = choice.scope
        vim.notify(("agentic: registered %s %s"):format(b.noun, choice.scope), vim.log.levels.INFO)
    end)
end

function M.current()
    return registered
end

function M.setup(_)
    vim.api.nvim_create_user_command("AgenticSendFile", function() M.send_file() end, {
        desc = "Send current file reference to claude",
    })
    vim.api.nvim_create_user_command("AgenticSendSelection", function() M.send_selection() end, {
        desc = "Send visual selection reference to claude",
        range = true,
    })
    vim.api.nvim_create_user_command("AgenticRegister", function() M.register() end, {
        desc = "Register any tmux session / wezterm workspace (overrides current targeting)",
    })
end

return M
