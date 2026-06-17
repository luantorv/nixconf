-- SPDX-FileCopyrightText: 2026 Luis Reis Viera
-- SPDX-License-Identifier: Apache-2.0

local telescope = require('telescope')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
            },
        },
    },
        extensions = {
            project = {
                hidden_files = true, 
                theme = "dropdown",  
                order_by = "recent", 
            }
        }
})

require('telescope').load_extension('project')

vim.keymap.set('n', '<leader>fp', ':Telescope project<CR>', { desc = "Buscar Proyectos" })