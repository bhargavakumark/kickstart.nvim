-- Autocommands
-- See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Show diagnostic popup on cursor hover
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

-- Bash LSP
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start {
      name = 'bash-language-server',
      cmd = { '/Users/bkancherla/.nvm/versions/node/v24.11.0/bin/bash-language-server', 'start' },
    }
  end,
})

-- Disable autoformat for C++
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cpp',
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Disable word wrap for .out, .output, .list files
vim.api.nvim_create_autocmd('BufReadPre', {
  pattern = { '*.out', '*.output', '*.list' },
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.sidescroll = 1
  end,
})

-- Highlight trailing whitespace in all buffers, excluding special filetypes
do
  vim.cmd([[highlight ExtraWhitespace guibg=#ff5f87 ctermbg=red]])

  local excluded_filetypes = {
    'fff',
    'NvimTree',
    'TelescopePrompt',
    'TelescopeResults',
    'notify',
    'help',
    'lazy',
    'avail',
    'checkhealth',
  }

  local whitespace_group = vim.api.nvim_create_augroup('WhitespaceHighlight', { clear = true })

  local function toggle_whitespace()
    local is_excluded = vim.tbl_contains(excluded_filetypes, vim.bo.filetype)
      or vim.bo.buftype ~= ''

    if is_excluded then
      vim.cmd('match ExtraWhitespace //')
    else
      vim.cmd([[match ExtraWhitespace /\s\+$/]])
    end
  end

  vim.api.nvim_create_autocmd({ 'BufWinEnter', 'InsertLeave', 'BufEnter' }, {
    group = whitespace_group,
    callback = toggle_whitespace,
  })

  vim.api.nvim_create_autocmd('InsertEnter', {
    group = whitespace_group,
    callback = function()
      local is_excluded = vim.tbl_contains(excluded_filetypes, vim.bo.filetype)
        or vim.bo.buftype ~= ''
      if not is_excluded then
        vim.cmd([[match ExtraWhitespace /\s\+\%#\@<!$/]])
      end
    end,
  })

  vim.api.nvim_create_autocmd('BufWinLeave', {
    group = whitespace_group,
    command = 'call clearmatches()',
  })
end

-- New .sh file template
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*.sh',
  callback = function()
    local filepath = vim.fn.expand '%:p'
    if vim.fn.filereadable(filepath) == 1 then
      vim.fn.system { 'chmod', '+x', filepath }
    end
    local lines = {
      '#!/bin/bash',
      '',
      'RED="\\e[0;31m"',
      'GREEN="\\e[0;32m"',
      'YELLOW="\\e[0;33m"',
      'BLUE="\\e[0;34m"',
      'NC="\\e[0m" # No Color',
      '',
      'function red() {',
      '  echo -e "${RED}$1${NC}"',
      '}',
      'function green() {',
      '  echo -e "${GREEN}$1${NC}"',
      '}',
      'function yellow() {',
      '  echo -e "${YELLOW}$1${NC}"',
      '}',
      'function blue() {',
      '  echo -e "${BLUE}$1${NC}"',
      '}',
      'function nocolor() {',
      '  echo -e "${NC}$1${NC}"',
      '}',
      '',
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.cmd 'normal G'
  end,
})
