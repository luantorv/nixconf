-- SPDX-FileCopyrightText: 2026 Luis Reis Viera
-- SPDX-License-Identifier: Apache-2.0

require("bufferline").setup({
    options = {
        mode = "buffers",
        separator_style = "thin",
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        
        offsets = {
            {
                filetype = "netrw",
                text = "File Explorer",
                text_align = "left",
                separator = true
            }
        }
    }
})