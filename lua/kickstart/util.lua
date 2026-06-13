-- Utility: openf (Open File Fuzzy Search)

local telescope = require('telescope.builtin')

function openf(pattern)
  local search_pattern = pattern or ''

  telescope.find_files({
    default_text = search_pattern,
    cwd = vim.fn.getcwd(),
    find_command = {
      'rg', '--files', '--hidden',
      '--glob', '!{.git}',
    },
  })
end

vim.api.nvim_create_user_command(
  'Openf',
  function(opts)
    openf(opts.args)
  end,
  { nargs = '?' }
)
