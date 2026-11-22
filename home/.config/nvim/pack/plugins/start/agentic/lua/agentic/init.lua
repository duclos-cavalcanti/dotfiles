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

-- A registered claude pane: once picked via :AgenticRegister, every send goes
-- straight to it, no prompt. Sticky until re-registered or the pane stops
-- running claude.
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

-- Pick a claude pane in nvim's current scope: the one there, or the one you
-- choose when there are several.
local function choose(b, callback)
    local scope = b.current_scope()
    if not scope then
        vim.notify(("agentic: not in a %s"):format(b.noun), vim.log.levels.WARN)
        return
    end
    local targets = b.claude_panes(scope)
    if #targets == 0 then
        vim.notify(("agentic: no claude in %s '%s'"):format(b.noun, scope), vim.log.levels.WARN)
        return
    end
    pick(targets, "agentic: select claude", callback)
end

-- The registered pane, if it still runs claude; else forget it.
local function live_registered(b)
    if not registered then return nil end
    for _, t in ipairs(b.claude_panes(registered.scope)) do
        if t.id == registered.id then return t end
    end
    vim.notify(("agentic: registered claude (%s) is gone"):format(registered.label), vim.log.levels.WARN)
    registered = nil
    return nil
end

-- The registered pane when live, else the same pick a send makes.
local function resolve(b, callback)
    local t = live_registered(b)
    if t then return callback(t) end
    choose(b, callback)
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

-- Register a claude pane: the same menu a send shows. Every send after goes
-- straight there.
function M.register()
    local b = backend()
    choose(b, function(t)
        registered = t
        vim.notify(("agentic: registered %s"):format(t.label), vim.log.levels.INFO)
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
        desc = "Pick a claude pane; every send goes there without asking",
    })
end

return M
