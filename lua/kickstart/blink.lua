-- Completion (blink.cmp) + AI completion (minuet-ai with DeepSeek)
--
-- AI completion uses DeepSeek's fill-in-the-middle endpoint, reached
-- through the local gateway at http://127.0.0.1:9904 (direct, no proxy):
--   http://127.0.0.1:9904/beta/completions
-- The API key is read from the DEEPSEEK_API_KEY environment variable.
-- Without the key, the minuet source is skipped entirely so nvim still
-- starts cleanly with LSP/path/buffer/snippets completion.

local has_deepseek_key = vim.env.DEEPSEEK_API_KEY ~= nil and vim.env.DEEPSEEK_API_KEY ~= ''

-- AI completion via DeepSeek (minuet-ai). Only enabled when the API key
-- is present in the environment.
if has_deepseek_key then
  require('minuet').setup {
    provider = 'openai_fim_compatible',
    provider_options = {
      openai_fim_compatible = {
        name = 'DeepSeek',
        end_point = 'http://127.0.0.1:9904/beta/completions',
        optional = {
          max_tokens = 256,
          top_p = 0.9,
        },
      },
    },
  }
end

local sources = { 'lsp', 'path', 'buffer', 'snippets' }
local providers = {}

if has_deepseek_key then
  table.insert(sources, 'minuet')
  providers.minuet = {
    name = 'minuet',
    module = 'minuet.blink',
    async = true,
    -- Should match minuet request_timeout (3s default) * 1000.
    timeout_ms = 3500,
    -- Prefer AI suggestions over local sources.
    score_offset = 50,
  }
end

require('blink.cmp').setup {
  keymap = {
    preset = 'default',
    -- Keep the scroll bindings from the old nvim-cmp setup.
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
  },
  sources = {
    default = sources,
    providers = providers,
  },
  completion = {
    -- Avoid firing AI requests the moment insert mode is entered.
    trigger = { prefetch_on_insert = false },
  },
  signature = { enabled = true },
  snippets = { preset = 'luasnip' },
}
