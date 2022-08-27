local options = {
    backup = false,                                     -- creates a backup file
    path = ".,**",
    tags = "./tags,tags;/",
    clipboard = "unnamedplus",                          -- allows neovim to access the system clipboard
    cmdheight = 2,                                      -- more space in the neovim command line for displaying messages
    completeopt = { "menuone","noinsert","noselect" },  -- mostly just for cmp
    conceallevel = 0,                                   -- so that `` is visible in markdown files
    signcolumn = "yes",
    fileencoding = "utf-8",                             -- the encoding written to a file
    hlsearch = false,                                   -- highlight all matches on previous search pattern
    incsearch = true,                                   -- show Search hit as you type
    ignorecase = true,                                  -- ignore case in search patterns
    mouse = "a",                                        -- allow the mouse to be used in neovim
    pumheight = 10,                                     -- pop up menu height
    showcmd = false,                                    -- dont Show commands while they are being typed
    showmode = false,                                   -- don't need to see modes
    showtabline = 2,                                    -- always show tabs
    smartcase = true,                                   -- smart case
    smartindent = true,                                 -- make indenting smarter again
    splitbelow = true,                                  -- force all horizontal splits to go below current window
    splitright = true,                                  -- force all vertical splits to go to the right of current window
    swapfile = false,                                   -- creates a swapfile
    termguicolors = true,                               -- set term gui colors (most terminals support this)
    timeoutlen = 500,                                   -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true,                                    -- enable persistent undo
    updatetime = 300,                                   -- faster completion (4000ms default)
    writebackup = false,                                -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true,                                   -- convert tabs to spaces
    shiftwidth = 4,                                     -- the number of spaces inserted for each indentation
    tabstop = 4,                                        -- insert 2 spaces for a tab
    softtabstop = 4,                                    -- insert 2 spaces for a tab
    cursorline = true,                                  -- highlight the current line
    number = true,                                      -- set numbered lines
    relativenumber = false,                             -- set relative numbered lines
    numberwidth = 4,                                    -- set number column width to 2 {default 4}
    cursorline = true,
    cursorcolumn = false,
    colorcolumn = "80",
    signcolumn = "yes",                                 -- always show the sign column, otherwise it would shift the text each time
    wrap = false,                                       -- display lines as one long line
    wrapscan = false,                                   -- dont Wrap Searches
    scrolloff = 8,                                      -- minimal number of screen lines to keep above and below cursor
    sidescrolloff = 8,
    number = true,
    relativenumber = false,
    hidden = true,
    spell = false,
    spelllang = "en_us",
    wildmode = "longest:full,full",
    confirm = false,
    autoread = true,
    lazyredraw = true,
}

vim.opt.shortmess:append "a"
vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- En/Disable inline error messages
vim.diagnostic.config {
    virtual_text = true,
    underline = true,            -- Keep error underline
    signs = true,                -- Keep gutter signs
}
