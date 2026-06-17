-- SPDX-FileCopyrightText: 2026 Luis Reis Viera
-- SPDX-License-Identifier: Apache-2.0

vim.deprecate = function() end
vim.g.mapleader = " "

vim.opt.splitright = true
vim.opt.splitbelow = true

local original_deprecate = vim.deprecate

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2 

-- Show buffers
vim.opt.showtabline = 2

vim.opt.number = true

vim.api.nvim_create_autocmd("TermClose", {
    pattern = "*",
    command = "if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif"
})