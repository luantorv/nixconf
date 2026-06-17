-- SPDX-FileCopyrightText: 2026 Luis Reis Viera
-- SPDX-License-Identifier: Apache-2.0

require('rose-pine').setup({
    variant = "auto", -- 'auto', 'main', 'moon', o 'dawn'
    dark_variant = "main",
    styles = {
        bold = true,
        italic = true,
        transparency = false,
    },
    highlight_groups = {
        -- Normal = { bg = "${config.colors.black}" },
        -- Keyword = { fg = "${config.colors.skyblue}" },
        -- String = { fg = "${config.colors.green}" },
        -- Error = { fg = "${config.colors.red}" },
        -- Warning = { fg = "${config.colors.coral}" },
    }
})

vim.cmd('colorscheme rose-pine')