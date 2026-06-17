-- SPDX-FileCopyrightText: 2026 Luis Reis Viera
-- SPDX-License-Identifier: Apache-2.0

local codewindow = require('codewindow')

codewindow.setup({
    active_in_terminals = false,
    auto_enable = false,
    minimap_width = 10,
    use_git = true,
    use_treesitter = true
})

vim.keymap.set('n', '<leader>m', codewindow.toggle_minimap, { desc = "Toggle Minimap"})