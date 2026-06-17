-- SPDX-FileCopyrightText: 2026 Luis Reis Viera
-- SPDX-License-Identifier: Apache-2.0

require('nvim-treesitter.configs').setup {
    highlight = { 
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    indent = {
        enable = true
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
        },
    },
}