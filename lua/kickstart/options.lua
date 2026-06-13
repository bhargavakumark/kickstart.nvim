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

-- Allow local .vimrc in project directories
vim.opt.exrc = true
vim.opt.secure = true

-- Keep buffers hidden when abandoned (allows switching without saving)
vim.opt.hidden = true
vim.opt.confirm = true

-- Folding
vim.opt.foldmethod = 'indent'
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 1

-- Diff mode: start in vertical split
vim.opt.diffopt:append('vertical')

-- Global tab/indent defaults
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Tags
vim.opt.tags = { 'tags;/', '~/.vim/tags/cpp_src' }

-- Tab completion
vim.opt.wildmode = { 'longest', 'list', 'full' }
-- Note: 'list:longest' set twice below is redundant; keeping the 'longest,list,full' order
vim.opt.wildmenu = true

-- Use interactive shell so bashrc aliases (gs, gd, gg) work in :! commands
vim.opt.shellcmdflag = '-ci'
