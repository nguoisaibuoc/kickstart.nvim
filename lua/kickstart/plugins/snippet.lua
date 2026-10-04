local gh = require('utils').gh

-- Helper function to check if there is a word before the cursor
local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

-- Snippet Engine
vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
require('luasnip').setup {}

-- Autocomplete Engine
vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
require('blink.cmp').setup {
  keymap = {
    preset = 'default',

    ['<Tab>'] = {
      function(cmp)
        -- If the popup is visible, select the next item
        if cmp.is_visible() then return cmp.select_next() end
        return false -- Proceed to next handler
      end,
      -- If inside a snippet, use tab to jump to the next placeholder
      'snippet_forward',
      function(cmp)
        -- If there is a word before the cursor, show the autocomplete popup
        if has_words_before() then return cmp.show() end
        return false
      end,
      -- Otherwise, act like a normal Tab (indent)
      'fallback',
    },

    ['<S-Tab>'] = {
      function(cmp)
        if cmp.is_visible() then return cmp.select_prev() end
        return false
      end,
      'snippet_backward',
      'fallback',
    },

    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
  },

  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {
    menu = { auto_show = false },
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets' },
  },

  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'lua' },
  signature = { enabled = true },
}
