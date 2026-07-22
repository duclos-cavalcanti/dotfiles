-- Reusable helper functions (consumed by keys.lua and elsewhere).
local M = {}

-- Toggle a single reusable terminal in a bottom split.
function M.toggle_terminal()
    local t = vim.g._term or {}
    if t.win and vim.api.nvim_win_is_valid(t.win) then
        vim.api.nvim_win_hide(t.win)              -- visible -> hide
        t.win = nil
    else
        vim.cmd("botright 30 split")              -- open a bottom split
        if t.buf and vim.api.nvim_buf_is_valid(t.buf) then
            vim.api.nvim_set_current_buf(t.buf)   -- reuse existing terminal
        else
            vim.cmd("terminal")                   -- first time: spawn shell
            t.buf = vim.api.nvim_get_current_buf()
        end
        t.win = vim.api.nvim_get_current_win()
        vim.cmd("startinsert")
    end
    vim.g._term = t
end

-- True if a quickfix window is open in the current tab.
function M.is_quickfix_open()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "quickfix" then
            return true
        end
    end
    return false
end

-- Open the current buffer's file in the macOS "Markdown Preview" app
-- (https://markdownpreview.app, installed via install.sh). Verifies the app is
-- installed and the buffer is a saved file before launching.
function M.open_markdown_preview()
    local app = "Markdown Preview"
    -- ask LaunchServices (what `open -a` uses) if the app is registered anywhere
    -- -- location-agnostic, unlike a PATH/executable() check (a GUI .app isn't on PATH)
    vim.fn.system({ "osascript", "-e", ('id of app "%s"'):format(app) })
    if vim.v.shell_error ~= 0 then
        vim.notify(app .. ".app not found -- install it (install.sh)", vim.log.levels.WARN)
        return
    end
    local file = vim.api.nvim_buf_get_name(0)
    if file == "" or vim.fn.filereadable(file) == 0 then
        vim.notify("Markdown Preview: no saved file in this buffer", vim.log.levels.WARN)
        return
    end
    vim.fn.jobstart({ "open", "-a", app, file }, { detach = true })
end

return M
