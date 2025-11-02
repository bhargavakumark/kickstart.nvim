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

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

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
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

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

  --{
  --  'ggml-org/llama.vim',
  --},

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

-- Start bash-language-server for bash LSP, instructions from
-- https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#neovim
  {
    'xiantang/darcula-dark.nvim', -- Use the correct repo name here
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false, -- Load immediately on startup
    priority = 1000, -- Load before most other plugins
    -- Optional: If it requires treesitter: dependencies = { "nvim-treesitter/nvim-treesitter" }
  },
  {
     'ntpeters/vim-better-whitespace',
  },
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

  {
    'doums/darcula',
  },
})

-- Allows snippets to handle <Tab> for final jumps. from hrsh7th/.*vsnip
vim.g.vsnip_append_final_tabstop = 1 -- Lua
vim.g.vsnip_deactivate_on = 'InsertLeave'

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'lua', 'python', 'go' },
  highlight = {
    enable = true,
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start {
      name = 'bash-language-server',
      cmd = { '/usr/local/google/home/bhargavakumark/.nvm/versions/node/v20.13.1/bin/bash-language-server', 'start' },
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

"set number relativenumber
set number
:nmap <F5> :set nonumber<CR>
set exrc " .vimrc in local project dir
set secure

" When moving with ctrl+], this save buffer hidden
set hidden
set confirm

set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

set diffopt+=vertical   "start diff in vertical mode

"Below for \t tab alignments
":set shiftwidth=8
":set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
"Below for 4 space tab aligments
":set tabstop=8 softtabstop=4 shiftwidth=4 noexpandtab
:set shiftwidth=4 tabstop=4 softtabstop=4 shiftwidth=4 expandtab
if has("autocmd")
    " For java files use \t as separator
    autocmd BufRead,BufNewFile *.java :set shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    autocmd BufRead,BufNewFile *.js :set shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    autocmd BufRead,BufNewFile *.cpp :set shiftwidth=4 tabstop=4 softtabstop=4 shiftwidth=4 expandtab
    "autocmd BufRead,BufNewFile *.cpp :set shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    "autocmd BufRead,BufNewFile *.sh :set shiftwidth=4 tabstop=4 softtabstop=4 shiftwidth=4 expandtab
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

" pathogen
"execute pathogen#infect()

" Use deoplete.
let g:deoplete#enable_at_startup = 1
"  Run UpdateRemotePlugins it not loading

"-- TRUE COLOR --
" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has("termguicolors") && $TERM_PROGRAM ==# 'iTerm.app')
  set termguicolors
endif

" pathogen
"execute pathogen#infect()

" Use deoplete.
let g:deoplete#enable_at_startup = 1
"  Run UpdateRemotePlugins it not loading

"-- TRUE COLOR --
" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has("termguicolors") && $TERM_PROGRAM ==# 'iTerm.app')
  set termguicolors
endif

"-- THEMING --
set cursorline          " current line is underlined
set background=dark

let g:airline_theme='material'
"let g:material_theme_style = 'darker'
"colorscheme material
"colorscheme kanagawa
"colorscheme darcula-dark
colorscheme darcula

hi Normal       ctermbg=NONE guibg=NONE
hi SignColumn   ctermbg=235 guibg=#262626
hi LineNr       ctermfg=grey guifg=grey ctermbg=NONE guibg=NONE
hi CursorLineNr ctermbg=NONE guibg=NONE ctermfg=178 guifg=#d7af00

"-- Airline --
let g:airline#extensions#tabline#enabled = 1

let g:gitgutter_set_sign_backgrounds = 0

" I have put this plugin in ~/.config/nvim/bundle , but it doesn't seem to
" load
"-- Whitespace highlight --
"match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

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

" set NERDTreeWinPos="right"		" Doesn't work anymore

" Sometimes when vim loads, there are errors, these errors don't show up
" if nerdtree is enabled. Disable NERDTree and start again to see errors
" Start NERDTree
"autocmd VimEnter * NERDTree
" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * wincmd p

"autocmd VimEnter * wincmd p
":NERDTreeToggle

nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-t> :NERDTreeToggle<CR>
:nmap <F4> :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFind<CR>

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>


" open file at the same line as we closed
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

""-- ALE --
"hi clear ALEErrorSign
"hi clear ALEWarningSign
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_sign_error = '‚úò'
"let g:ale_sign_warning = '‚óã'
"hi Error    ctermfg=204 ctermbg=NONE guifg=#ff5f87 guibg=NONE
"hi Warning  ctermfg=178 ctermbg=NONE guifg=#D7AF00 guibg=NONE
"hi ALEError ctermfg=204 guifg=#ff5f87 ctermbg=52 guibg=#5f0000 cterm=undercurl gui=undercurl
"hi link ALEErrorSign    Error
"hi link ALEWarningSign  Warning
"
"let g:ale_linters = {
"            \ 'python': ['pylint'],
"            \ 'javascript': ['eslint'],
"            \ 'go': ['gobuild', 'gofmt'],
"            \ 'rust': ['rls']
"            \}
"let g:ale_fixers = {
"            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
"            \ 'python': ['autopep8'],
"            \ 'javascript': ['eslint'],
"            \ 'go': ['gofmt', 'goimports'],
"            \ 'rust': ['rustfmt']
"            \}
"let g:ale_fix_on_save = 1
"
""-- NERDTree --
"let NERDTreeShowHidden=1
"
""-- Airline --
"let g:airline#extensions#tabline#enabled = 1
"
""uo-- NVIM configuration --
"if has('nvim')
"    " Enable deoplete when InsertEnter.
"    let g:deoplete#enable_at_startup = 0
"    autocmd InsertEnter * call deoplete#enable()
"
"    set belloff=""
"    call deoplete#custom#source('_',  'max_menu_width', 0)
"    call deoplete#custom#source('_',  'max_abbr_width', 0)
"    call deoplete#custom#source('_',  'max_kind_width', 0)
"
"    set hidden
"    let g:LanguageClient_serverCommands = {
"        \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"        \ 'go': ['~/.go/bin/gopls']
"        \ }
"endif

" Disable gutenttags run on file close
let g:gutentags_generate_on_write=0


set tags=tags;/
set tags+=~/.vim/tags/cpp_src
"helptags ~/.vim/doc

"if has("cscope")
"  set csto=1
"  set nocst
"  set nocsverb
"  " add any database in current directory
"  if filereadable("cscope.out")
"    cs add cscope.out
"    " else add database pointed to by environment
"  elseif $CSCOPE_DB != ""
"    cs add $CSCOPE_DB
"  endif
"  set csverb
"endif

" https://vim.fandom.com/wiki/Autoloading_Cscope_Database
"function! LoadCscope()
"  let db = findfile("cscope.out", ".;")
"  if (!empty(db))
"    let path = strpart(db, 0, match(db, "/cscope.out$"))
"    set nocscopeverbose " suppress 'duplicate connection' error
"    exe "cs add " . db . " " . path
"    set cscopeverbose
"  " else add the database pointed to by environment variable 
"  elseif $CSCOPE_DB != "" 
"    cs add $CSCOPE_DB
"  endif
"endfunction
"au BufEnter /* call LoadCscope()

set ic

" autocomplete for attached debugger on go
au FileType dap-repl lua require('dap.ext.autocompl').attach()

" Key bindings for trouble.nvim from https://github.com/folke/trouble.nvim?tab=readme-ov-file#commands
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xf <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap <leader>xr <cmd>TroubleToggle lsp_references<cr>

" vim cycle tabs with gt
nnoremap gt :tabnext<CR>


" Settings from https://groups.google.com/a/google.com/g/vi-users/c/jyVNZjO7Eps/m/Vwn-aqYkBQAJ
"
" Not using settings for go as its already being formatted correctly
augroup autoformat_settings
"  autocmd FileType bzl AutoFormatBuffer buildifier
"  autocmd FileType go AutoFormatBuffer gofmt
"  See go/vim/plugins/codefmt-google, :help codefmt-google and :help codefmt
"  for details about other available formatters.
augroup END

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
  if current_file:match '/google/src/cloud/' then
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    require 'lsp' -- CiderLSP
    require 'diagnostics' -- Diagnostics
    vim.cmd 'Copilot disable'
  end
  if current_file:match '/usr/local/google/home/bhargavakumark/git' then
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    require 'lsp' -- CiderLSP
    require 'diagnostics' -- Diagnostics
    vim.cmd 'Copilot enable'
  end
  if current_file:match '/usr/local/google/home/bhargavakumark/issues' then
    vim.cmd 'Copilot disable'
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
      'function ECHO_RED() {',
      '  echo -e "${RED}$1${NC}"',
      '}',
      'function ECHO_GREEN() {',
      '  echo -e "${GREEN}$1${NC}"',
      '}',
      'function ECHO_YELLOW() {',
      '  echo -e "${YELLOW}$1${NC}"',
      '}',
      'function ECHO_BLUE() {',
      '  echo -e "${BLUE}$1${NC}"',
      '}',
      'function ECHO_NC() {',
      '  echo -e "${NC}$1${NC}"',
      '}',
      '',
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.cmd 'normal G' -- Move cursor to end
  end,
})
