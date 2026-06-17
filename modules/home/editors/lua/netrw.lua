-- SPDX-FileCopyrightText: 2026 Luis Reis Viera
-- SPDX-License-Identifier: Apache-2.0

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

vim.g.netrw_winsize = 25
vim.g.netrw_list_hide = [[\(^\|\s\s\)\(\.git\)\($\|\s\s\)]]

vim.api.nvim_create_autocmd('filetype', {
    pattern = 'netrw',
    desc = 'Mejoras estéticas para Netrw',
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.keymap.set('n', 'q', ':Lexplore<CR>', { remap = true, buffer = true })
    end
})