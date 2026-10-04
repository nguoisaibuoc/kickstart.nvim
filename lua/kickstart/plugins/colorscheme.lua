local gh = require('utils').gh

local themes = {
  gh 'folke/tokyonight.nvim',
  gh 'rebelot/kanagawa.nvim',
  gh 'sainnhe/everforest',
  gh 'sainnhe/sonokai',
  gh 'sainnhe/gruvbox-material',
  { src = gh 'catppuccin/nvim', name = 'catppuccin' },
}

vim.pack.add(themes)

vim.g.everforest_background = 'hard'
vim.g.everforest_enable_italic = false
vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground = 'original'
vim.g.gruvbox_material_enable_italic = false

vim.cmd.colorscheme 'gruvbox-material'
