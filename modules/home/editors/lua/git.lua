-- SPDX-FileCopyrightText: 2026 Luis Reis Viera
-- SPDX-License-Identifier: Apache-2.0

-- Git indicators
require('gitsigns').setup({
    signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
    },
})

-- Keybind for LazyGit
vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', { silent = true, desc = "Abrir LazyGit" })