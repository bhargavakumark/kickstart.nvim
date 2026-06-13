-- LSP Configuration
-- nvim-lspconfig, Mason, and per-language server setup

-- JDTLS (Java)
local home = os.getenv('HOME')
local jdtls_path = home .. '/jdt-language-server'
local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/.cache/jdtls/workspace/' .. project_name

vim.lsp.config('jdtls', {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', launcher_jar,
    '-configuration', jdtls_path .. '/config_mac',
    '-data', workspace_dir,
  },
  root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew', 'pom.xml' }),
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
    },
  },
})
vim.lsp.enable('jdtls')

-- Lua LSP
vim.lsp.config('luals', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc' },
})
vim.lsp.enable('luals')

-- Go LSP (gopls)
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gosum' },
  root_markers = { 'go.mod', '.git' },
})
vim.lsp.enable('gopls')
