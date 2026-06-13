-- Plugin Manager Bootstrap

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Tabstop/shiftwidth detection
  'tpope/vim-sleuth',

  -- File icons (needed by nvim-tree, telescope)
  {
    'nvim-tree/nvim-web-devicons',
    lazy = false,
    priority = 1000,
    config = function()
      require('nvim-web-devicons').setup {
        override = {
          ['lua'] = { icon = '', color = '#51a0cf' },
        },
      }
    end,
  },

  -- GitHub Copilot
  {
    'github/copilot.vim',
  },

  -- Comment toggling with gc
  { 'numToStr/Comment.nvim', opts = {} },

  -- Colorscheme
  {
    'xiantang/darcula-dark.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('darcula-dark')
    end,
  },

  -- Git signs in the gutter
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Highlight TODO, FIXME, etc. in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- Treesitter (syntax highlighting, indentation)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash', 'c', 'diff', 'html', 'lua', 'luadoc',
        'markdown', 'vim', 'vimdoc', 'go', 'gomod', 'gowork', 'gosum',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  -- Core LSP / Mason
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/mason.nvim', cmd = 'Mason' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'mfussenegger/nvim-jdtls' },

  -- Autocompletion
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'L3MON4D3/LuaSnip' },

  -- File explorer sidebar
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        view = { width = 35, side = 'left' },
        renderer = { indent_markers = { enable = true } },
        update_focused_file = { enable = true },
        filters = { dotfiles = false },
        actions = {
          open_file = { quit_on_open = false },
        },
      }

      -- Close nvim-tree when it's the last window
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        callback = function()
          if vim.bo.filetype == 'NvimTree' and #vim.api.nvim_list_wins() == 1 then
            vim.cmd('quit')
          end
        end,
      })
    end,
    keys = {
      { '<leader>e', ':NvimTreeToggle<CR>', desc = 'Toggle File Explorer' },
      { '<Esc>b', ':NvimTreeToggle<CR>', desc = 'Toggle File Explorer' },
    },
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        defaults = {
          path_display = { 'truncate' },
          layout_config = {
            preview_width = 0.4,
            width = 0.98,
            height = 0.98,
          },
          mappings = {
            i = {
              ['<CR>'] = require('telescope.actions').select_tab,
              ['<S-CR>'] = require('telescope.actions').select_default,
            },
            n = {
              ['<CR>'] = require('telescope.actions').select_tab,
              ['t'] = require('telescope.actions').select_tab,
            },
          },
        },
        pickers = {
          find_files = {},
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'

      -- Telescope keymaps
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<Esc>p', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- Fuzzy finder alternative (fff)
  {
    'dmtrKovalenko/fff.nvim',
    build = function()
      require('fff.download').download_or_build_binary()
    end,
    opts = {
      debug = { enabled = true, show_scores = true },
      picker = {
        winblend = 0,
      },
      layout = {
        width = 0.98,
        height = 0.98,
        prompt_position = 'bottom',
        preview_position = 'right',
        preview_size = 0.5,
      },
      path_display = { 'truncate' },
    },
    keys = {
      { 'ff', function() require('fff').find_files() end, desc = 'Find files' },
      { '<leader>fg', function() require('fff').find_in_git_root() end, desc = 'Git files' },
    },
  },
})
