-- SPDX-FileCopyrightText: 2026 Luis Reis Viera
-- SPDX-License-Identifier: Apache-2.0

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")

vim.keymap.set('n', '<C-b>', ':Lexplore<CR>', { silent = true })

-- Terminal
vim.keymap.set('n', '<C-t>', ':vsplit | terminal<CR>i', { silent = true })

-- bufferline
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { silent = true })
vim.keymap.set('n', '<C-q>', ':bd<CR>', { silent = true})

vim.keymap.set('n', '<leader>/', ':vsplit | wincmd h | bprevious | wincmd l<CR>', { desc = "Mover buffer actual a split derecho", silent = true })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Mover a ventana izquierda" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Mover a ventana derecha" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Mover a ventana abajo" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Mover a ventana arriba" })

-- Keybinds for LSP
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, { desc = "Go to Definition" })
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, { desc = "Hover Documentation" })
vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, { desc = "Code Action" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)

-- General Keybind for File Search 
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').find_files, { desc = "Buscar archivos" })

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fr', builtin.lsp_references)
vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions)