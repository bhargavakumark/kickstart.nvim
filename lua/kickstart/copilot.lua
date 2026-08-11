-- Copilot enable/disable based on file path

local function disable_copilot_by_path()
  local current_file = vim.fn.expand '%:p'

  if current_file:match '/Users/bkancherla/' then
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    vim.cmd 'Copilot disable'
  end
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead' }, {
  pattern = '*',
  callback = disable_copilot_by_path,
})

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*',
  callback = disable_copilot_by_path,
})
