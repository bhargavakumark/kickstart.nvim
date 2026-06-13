-- Options
-- See `:help vim.opt` and `:help option-list`

vim.opt.termguicolors = true

-- Line numbers
vim.opt.number = true
-- vim.opt.relativenumber = true

-- Mouse mode (disabled as may interfere with Ghostty select/copy)
vim.opt.mouse = 'a'

-- Don't show mode (already in status line)
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or caps in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time (displays which-key popup sooner)
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Whitespace display
vim.opt.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- Set highlight on search
vim.opt.hlsearch = true

-- Clipboard: disable auto-sync with system clipboard
-- Deletions (dw, dd) go to internal register. Paste from system: "+p
vim.opt.clipboard = ''
