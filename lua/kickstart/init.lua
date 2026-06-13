-- Kickstart Neovim Configuration
-- Load order matters: bootstrap → options → keymaps → autocmds → plugins → LSP

-- Bootstrap: netrw disable, leader key
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- Core settings
require('kickstart.options')
require('kickstart.keymaps')

-- Autocommands (includes whitespace highlighting, file templates, LSP hooks)
require('kickstart.autocmds')

-- Plugin manager and plugin specs
require('kickstart.lazy')

-- LSP configuration (JDTLS, gopls, luals)
require('kickstart.lsp')

-- Copilot enable/disable logic
require('kickstart.copilot')

-- Spell correction abbreviations
require('kickstart.spell')

-- Utility commands (Openf)
require('kickstart.util')
