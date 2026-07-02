-- Keymaps
-- See `:help vim.keymap.set()`

-- Yank to system clipboard with Cmd+C (visual mode)
vim.keymap.set('v', '<D-c>', '"+y', { noremap = true, silent = true })

-- Diagnostic navigation
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode with double-Esc
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation with Ctrl+hjkl
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- LSP navigation
vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, { desc = 'Go to definition (LSP)' })
vim.keymap.set('n', '<C-t>', '<C-o>', { desc = 'Jump back (LSP)' })

-- Walk up the directory tree looking for a .git entry (directory or file for submodules).
-- Returns the repo root or nil.
local function find_git_root(start)
  local dir = start
  while dir do
    if vim.fn.isdirectory(dir .. '/.git') == 1 or vim.fn.filereadable(dir .. '/.git') == 1 then
      return dir
    end
    if dir == '/' then
      break
    end
    dir = dir:match('^(.+)/[^/]+$')
  end
  return nil
end

-- Smart gf: open file under cursor, handles git diff paths, always opens in new tab
vim.keymap.set('n', 'gf', function()
  local line = vim.fn.getline('.')
  local file

  -- Handle git diff +++ and --- lines (three + or - signs followed by space)
  local diff_path = line:match('^[%+%-][%+%-][%+%-] (.+)$')
  if diff_path then
    -- Strip the a/ or b/ prefix git diff adds
    diff_path = diff_path:gsub('^[ab]/', '')
    if diff_path == '/dev/null' then
      vim.notify('gf: /dev/null -- nothing to open', vim.log.levels.ERROR)
      return
    end
    file = diff_path
  else
    -- Not a diff line -- use the word under cursor (same as default gf)
    file = vim.fn.expand('<cfile>')
  end

  if not file or file == '' then
    vim.notify('gf: no file under cursor', vim.log.levels.ERROR)
    return
  end

  -- Collect unique base directories to try
  local bases = {}
  local seen = {}

  local cwd = vim.fn.getcwd()
  local buf_dir = vim.fn.expand('%:p:h')

  -- Helper to add a base if not already seen
  local function add_base(dir)
    if dir and dir ~= '' and not seen[dir] then
      seen[dir] = true
      table.insert(bases, dir)
    end
  end

  add_base(cwd)
  add_base(find_git_root(cwd))
  add_base(buf_dir)
  add_base(find_git_root(buf_dir))

  -- Try each base
  for _, base in ipairs(bases) do
    local full = base .. '/' .. file
    if vim.fn.filereadable(full) == 1 or vim.fn.isdirectory(full) == 1 then
      vim.cmd('tabedit ' .. vim.fn.fnameescape(full))
      return
    end
  end

  vim.notify('gf: file not found: ' .. file, vim.log.levels.ERROR)
end, { desc = 'Smart gf: open file, resolves git diff paths, always opens in new tab' })
