--[[
--

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- NOTE: Some shortcuts using Command+key (on Mac) require allowing the character
-- through iterm settings. For any shortcuts that use Command, make sure to create
-- mapping in iterm2 Preferences > Profiles > Keys > Key Bindings > +
-- Keyboard Shortcut: Press ⌘B <or whatever key you want>
-- Action: Send Escape Sequence
-- Esc+: (this will send <Esc> followed by :)
-- This allows you to use Command+key combinations to map to 'Esc' key shortcuts

-- Disables the built-in file explorer (netrw) which conflicts with nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Optional, but highly recommended for icons (requires a patched font like Nerd Font)
vim.opt.termguicolors = true

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a' -- Disabled as might be interferring with ghostty select and copy
vim.keymap.set('v', '<D-c>', '"+y', { noremap = true, silent = true })

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,  -- Eager load for icons (needed by nvim-tree, telescope)
    priority = 1000,
    enabled = true,  -- Override any cond
    config = function()
      require("nvim-web-devicons").setup {
        -- optional: override default colors
        override = {
          ["lua"] = { icon = "", color = "#51a0cf" },
        },
      }
    end,
  },
  {
    'github/copilot.vim',
  },

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  {
    'xiantang/darcula-dark.nvim',
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false, -- Load immediately on startup
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("darcula-dark")
    end,
  },
  -- Using `highlight ExtraWhitespace` instead of this now
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
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

  -- note: plugins can also be configured to run lua code when they are loaded.
  --
  -- this is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- for example, in the following configuration, we use:
  --  event = 'vimenter'
  --
  -- which loads which-key before all the ui elements are loaded. events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'go', 'gomod', 'gowork', 'gosum' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  -- Core LSP/Mason Plugins
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", cmd = "Mason" },
  { "williamboman/mason-lspconfig.nvim" },
  { "mfussenegger/nvim-jdtls" },

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  {'L3MON4D3/LuaSnip'},

  -- nvim-tree that shows files list in the left pane
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      -- Required for file icons (need a Nerd Font installed)
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      -- The setup function is called here (see snippet 3)
      -- Global setup first
      require("nvim-tree").setup {
        view = { width = 35, side = "left" },
        renderer = { indent_markers = { enable = true } },
        update_focused_file = { enable = true },
        filters = { dotfiles = false },
        actions = {
          open_file = {
            quit_on_open = false,  -- Keep tree open
          },
        },
      }

      -- Auto-open on VimEnter, focus editor (wincmd p equivalent)
      -- vim.api.nvim_create_autocmd("VimEnter", {
      --   callback = function()
      --     vim.defer_fn(function()
      --       require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
      --       vim.cmd("wincmd p")  -- Switch to previous/editor window
      --     end, 10)
      --   end,
      -- })

      -- Close if only tree left (optional)
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        callback = function()
          local filetype = vim.bo.filetype
          if filetype == "NvimTree" and #vim.api.nvim_list_wins() == 1 then
            vim.cmd("quit")
          end
        end,
      })
    end,
    -- Define a keymap to toggle it easily
    keys = {
      { '<leader>e', ':NvimTreeToggle<CR>', desc = 'Toggle File Explorer' },
      -- Esc is configured in iterm2 to be passed when pressing cmd+b
      { '<Esc>b', ':NvimTreeToggle<CR>', desc = 'Toggle File Explorer' }
    }
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        -- In your Telescope setup file (e.g., ~/.config/nvim/lua/plugins/telescope.lua)

        defaults = {
          -- path_display = { "filename_first" }, -- Doesn't seem to work as expected
          path_display = { "truncate" },
          layout_config = {
            preview_width = 0.4,
            -- Setting padding to 0 for both width and height
            -- tells Telescope to use the full available space minus status lines/tab lines.
            width = 0.98,
            height = 0.98,

            -- Optional: You can also explicitly set a large percentage value close to 1
            -- width = { padding = 0 },
            -- height = { padding = 0 },
            -- width = 0.95, -- 95% of the window width
            -- height = 0.9, -- 90% of the window height
          },
          -- Key mappings apply to all pickers unless overridden
          mappings = {
            -- i (Insert) Mode Mappings
            i = {
              -- Set Enter (<CR>) to open the file in a new tab/buffer
              ["<CR>"] = require('telescope.actions').select_tab,

              -- Optional: Keep the standard 'select_default' on Shift+CR for flexibility
              ["<S-CR>"] = require('telescope.actions').select_default,
            },

            -- n (Normal) Mode Mappings
            n = {
              -- Set Enter (<CR>) to open the file in a new tab/buffer
              ["<CR>"] = require('telescope.actions').select_tab,

              -- Optional: Map 't' to the tab action as well
              ["t"] = require('telescope.actions').select_tab,
            },
          },
        },
        -- You can also override specific picker options if needed
        pickers = {
            find_files = {
                -- The mappings defined in 'defaults' above will apply here
            }
        }
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<Esc>p', builtin.find_files, { desc = '[S]earch [F]iles' }) -- For iterm2
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  {
    'dmtrKovalenko/fff.nvim',
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    opts = {
      debug = { enabled = true, show_scores = true }, -- Enable during trial
      picker = {
        winblend = 0, -- Set to 0 to avoid "muddy" background colors with Darcula
      },
      layout = {
        width = 0.98,
        height = 0.98,
        prompt_position = 'bottom',
        preview_position = 'right',
        preview_size = 0.5,
      },
      -- PATH CONFIGURATION:
      -- "absolute" or "relative" (relative is usually better for core repo)
      path_display = { "truncate" },
    },
    lazy = false, -- Auto lazy-loads
    keys = {
      { 'ff', function() require('fff').find_files() end, desc = 'Find files' },
      { '<leader>fg', function() require('fff').find_in_git_root() end, desc = 'Git files' },
    },
}



})

-- Based on https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file
local home = os.getenv("HOME")
local jdtls_path = home .. "/jdt-language-server"

-- 1. Dynamically find the launcher jar
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- 2. Setup a unique workspace directory per project
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name
vim.lsp.config("jdtls", {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

    "-jar", launcher_jar,
    "-configuration", jdtls_path .. "/config_mac",
    "-data", workspace_dir,
  },
  root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" }),
  settings = {
    java = {
      -- Custom eclipse.jdt.ls options go here
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
    },
  },
})
vim.lsp.enable("jdtls")

-- lua LSP config
vim.lsp.config('luals', {
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  root_markers = {'.luarc.json', '.luarc.jsonc'},
})
vim.lsp.enable('luals')

-- go LSP config
vim.lsp.config('gopls', {
  cmd = {'gopls'},
  filetypes = {'go', 'gomod', 'gowork', 'gosum'},
  root_markers = {'go.mod', '.git'},
})


-- Allows snippets to handle <Tab> for final jumps. from hrsh7th/.*vsnip
-- Start bash-language-server for bash LSP, instructions from
-- https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#neovim
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start {
      name = 'bash-language-server',
      cmd = { '/Users/bkancherla/.nvm/versions/node/v24.11.0/bin/bash-language-server', 'start' },
    }
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cpp',
  callback = function()
    vim.b.autoformat = false
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
vim.cmd [[
set notimeout
set encoding=utf-8

set runtimepath^=~/.nvim runtimepath+=~/.nvim/after
let &packpath = &runtimepath

set exrc
set secure

set hidden
set confirm

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

set diffopt+=vertical

set shiftwidth=4 tabstop=4 softtabstop=4 shiftwidth=4 expandtab
if has("autocmd")
  autocmd BufRead,BufNewFile *.java :set shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd BufRead,BufNewFile *.js :set shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd BufRead,BufNewFile *.cpp :set shiftwidth=4 tabstop=4 softtabstop=4 shiftwidth=4 expandtab
  autocmd BufRead,BufNewFile *.sh :set shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd BufRead,BufNewFile *bashrc_common :set shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd BufRead,BufNewFile *.bash :set shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd BufRead,BufNewFile gob :set shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd BufRead,BufNewFile *.pl :set shiftwidth=8 tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
  autocmd BufRead,BufNewFile *.go :set shiftwidth=8 tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
  autocmd BufRead,BufNewFile *.yaml :set shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd BufRead,BufNewFile *.md :set shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd BufRead,BufNewFile *.json :set shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  autocmd BufRead,BufNewFile *.lua :set shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
endif

": spell corrections
:iabbrev teh the
:iabbrev aer are
:iabbrev etst test
:iabbrev shoudl should
:iabbrev lenght length
:iabbrev unxi unix
:iabbrev ofr for
:iabbrev disbale disable
:iabbrev meida media
:iabbrev Meida Media
:iabbrev hte the
:iabbrev deivce device
:iabbrev optinos options
:iabbrev referenece reference
:iabbrev witdh width
:iabbrev ouput output
:iabbrev prinft printf
:iabbrev evn env
:iabbrev gruop group
:iabbrev updrestore udprestore
:iabbrev hcm hmc
:iabbrev hcmHost hmcHost
:iabbrev hcmLpar hmcLpar
:iabbrev iamge image
:iabbrev virutal virtual
:iabbrev strint string
:iabbrev ERORR ERROR
:iabbrev instnace instance
:iabbrev clsuter cluster
:iabbrev mulitple multiple
:iabbrev availablity availability
:iabbrev depedencies dependencies
:iabbrev depedency dependency
:iabbrev enviormnent environment

" open file at the same line as we closed
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

set tags=tags;/
set tags+=~/.vim/tags/cpp_src

" Tab completion
set wildmode=longest,list,full
set wildmenu
set wildmode=list:longest
set winheight=9999
set so=5
]]
--
-- Disable Copilot for specific file types or paths
--
local function disable_copilot_by_path()
  local current_file = vim.fn.expand '%:p' -- Get full path of current file

  --  -- List of paths/patterns where Copilot should be disabled
  --  local disabled_paths = {
  --    '/google/src/cloud/',
  --  }
  --
  --  -- Check if current file matches any disabled path pattern
  --  for _, path_pattern in ipairs(disabled_paths) do
  --    if string.find(current_file, path_pattern) then
  --      vim.cmd 'Copilot disable'
  --      return -- Exit after first match
  --    end
  --  end
  -- vim.cmd 'Copilot disable'
  -- if current_file:match '/Users/bkancherla/git/' then
  if current_file:match '/Users/bkancherla/' then
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    -- require 'lsp' -- CiderLSP
    -- require 'diagnostics' -- Diagnostics
    vim.cmd 'Copilot enable'
  end
end

-- Set up autocmd to run when opening files
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead' }, {
  pattern = '*',
  callback = disable_copilot_by_path,
})

-- Optional: Also run when creating new files
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*',
  callback = disable_copilot_by_path,
})

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*.sh',
  callback = function()
    vim.fn.system { 'chmod', '+x', vim.fn.expand '%:p' }
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
    vim.cmd 'normal G' -- Move cursor to end
  end,
})

-- ========================================================
-- Custom Function: openf (Open File Fuzzy Search)
-- Requires: nvim-telescope/telescope.nvim
-- ========================================================

local telescope = require('telescope.builtin')

function openf(pattern)
  -- Default to searching all files if no pattern is provided
  local search_pattern = pattern or ""

  -- Use telescope's 'find_files' to search the current directory and subdirectories.
  -- Telescope uses git ls-files if available, making it very fast.
  telescope.find_files({
    -- Start the search with the user-provided pattern already typed in the prompt
    default_text = search_pattern,
    -- Search recursively from the current directory
    cwd = vim.fn.getcwd(),
    -- Use the default file finder settings (respects .gitignore)
    find_command = {
        'rg', '--files', '--hidden',
        '--glob', '!{.git}',  -- Exclude files in the .git directory explicitly
    }
  })
end

-- --------------------------------------------------------
-- Create a Vim command to easily call the Lua function from the command line
-- Usage: :Openf <search_pattern>
-- --------------------------------------------------------
vim.api.nvim_create_user_command(
  'Openf',
  function(opts)
    -- opts.args contains the string passed to the command
    openf(opts.args)
  end,
  { nargs = '?' } -- Allows 0 or 1 argument
)

-- In ~/.config/nvim/init.lua

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.opt.clipboard = 'unnamedplus'

-- Set the clipboard option to an empty string.
-- This DISABLES automatic synchronization between Vim's unnamed register ("")
-- and the system clipboard (+) or primary selection (*).
vim.opt.clipboard = ''
-- Now:
-- Deletions (dw, dd, etc.) go to the internal unnamed register (""). P pastes it.
-- Cmd+V (System paste) pastes what was last explicitly copied with Cmd+C.
-- To yank to the system clipboard, you must explicitly use: "+y
-- To paste from the system clipboard, you must explicitly use: "+p

-- Key mapping to open file under cursor in a new tab
vim.api.nvim_set_keymap('n', 'gf', '<C-W>gf', { noremap = true, silent = true })

-- Show diagnostic popup on cursor hover
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

-- Highlight trailing whitespace in all buffers, but exclude certain filetypes and special windows
-- Define the look of the highlight (Red background)
vim.cmd([[highlight ExtraWhitespace guibg=#ff5f87 ctermbg=red]])

-- Define which filetypes should NEVER show trailing whitespace highlights
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

-- Function to check if we should apply the highlight
local function toggle_whitespace()
  -- Check 1: Is the filetype in our list?
  local is_excluded_ft = vim.tbl_contains(excluded_filetypes, vim.bo.filetype)

  -- Check 2: Is it a floating/special window? (fff uses 'nofile' or 'terminal')
  local is_special_buffer = vim.bo.buftype ~= ""

  if is_excluded_ft or is_special_buffer then
    vim.cmd('match ExtraWhitespace //') -- Clear match
  else
    vim.cmd([[match ExtraWhitespace /\s\+$/]]) -- Apply match
  end
end

-- Highlight trailing spaces when entering a buffer
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'InsertLeave', 'BufEnter' }, {
  group = whitespace_group,
  callback = toggle_whitespace,
})

-- Prevent highlighting the space at the end of the line while typing
vim.api.nvim_create_autocmd('InsertEnter', {
  group = whitespace_group,
  callback = function()
    local is_excluded_ft = vim.tbl_contains(excluded_filetypes, vim.bo.filetype)
    local is_special_buffer = vim.bo.buftype ~= ""

    if not (is_excluded_ft or is_special_buffer) then
      vim.cmd([[match ExtraWhitespace /\s\+\%#\@<!$/]])
    end
  end,
})

-- Clean up when leaving
vim.api.nvim_create_autocmd('BufWinLeave', {
  group = whitespace_group,
  command = 'call clearmatches()',
})
-- END: Highlight trailing whitespace in all buffers, but exclude certain filetypes and special windows


-- Disable word wrap for .out and .output files
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = { "*.out", "*.output", "*.list" },
  callback = function()
    vim.opt_local.wrap = false
    -- Optional: also enable horizontal scrolling with mouse if needed
    vim.opt_local.sidescroll = 1
  end,
})
